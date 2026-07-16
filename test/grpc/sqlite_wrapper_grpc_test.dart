import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart' as grpc;
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:test/test.dart';

class _FakeClientCall<Q, R> extends grpc.ClientCall<Q, R> {
  final Stream<R> _responseStream;
  bool cancelCalled = false;

  _FakeClientCall(this._responseStream, grpc.ClientMethod<Q, R> method)
      : super(method, const Stream.empty(), grpc.CallOptions());

  @override
  Stream<R> get response => _responseStream;

  @override
  Future<void> cancel() async {
    cancelCalled = true;
  }
}

class _FakeChannel extends grpc.ClientChannel {
  final StreamController<WatchResponse> controller;

  _FakeChannel(this.controller) : super('localhost', port: 0);

  @override
  grpc.ClientCall<Q, R> createCall<Q, R>(
    grpc.ClientMethod<Q, R> method,
    Stream<Q> requests,
    grpc.CallOptions options,
  ) {
    return _FakeClientCall<Q, R>(
      controller.stream as Stream<R>,
      method,
    );
  }
}

SqliteWrapperGRPC _createClientWithChannel(
    StreamController<WatchResponse> controller) {
  final channel = _FakeChannel(controller);
  final fakeClient = SqliteWrapperServiceClient(channel);
  final client = SqliteWrapperGRPC.withHostAndPort(
      host: 'localhost', port: 50051);
  client.clientOverride = fakeClient;
  return client;
}

void main() {
  group('SqliteWrapperGRPC.watch', () {
    test('emits initial result and listens for updates', () async {
      final controller = StreamController<WatchResponse>();
      final client = _createClientWithChannel(controller);

      final stream = client.watch(
        'SELECT * FROM test',
        tables: ['test'],
      );

      final events = <dynamic>[];
      final sub = stream.listen((e) => events.add(e));

      controller.add(WatchResponse(
        json: jsonEncode([
          {'id': 1, 'name': 'Alice'}
        ]),
        singleResult: false,
      ));
      controller.add(WatchResponse(
        json: jsonEncode([
          {'id': 1, 'name': 'Alice'},
          {'id': 2, 'name': 'Bob'}
        ]),
        singleResult: false,
      ));

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(events.length, 2);
      expect(events[0], [
        {'id': 1, 'name': 'Alice'}
      ]);
      expect(events[1], [
        {'id': 1, 'name': 'Alice'},
        {'id': 2, 'name': 'Bob'}
      ]);
    });

    test('applies fromMap when singleResult is false and data is a list',
        () async {
      final controller = StreamController<WatchResponse>();
      final client = _createClientWithChannel(controller);

      dynamic fromMap(Map<String, dynamic> m) => _TestModel(m['id'], m['name']);

      final stream = client.watch(
        'SELECT * FROM test',
        tables: ['test'],
        fromMap: fromMap,
      );

      final events = <dynamic>[];
      final sub = stream.listen((e) => events.add(e));

      controller.add(WatchResponse(
        json: jsonEncode([
          {'id': 1, 'name': 'Alice'}
        ]),
        singleResult: false,
      ));

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(events.length, 1);
      expect(events[0], isA<List>());
      expect((events[0] as List).first, isA<_TestModel>());
      expect((events[0] as List).first.id, 1);
    });

    test('applies fromMap when singleResult is true', () async {
      final controller = StreamController<WatchResponse>();
      final client = _createClientWithChannel(controller);

      dynamic fromMap(Map<String, dynamic> m) => _TestModel(m['id'], m['name']);

      final stream = client.watch(
        'SELECT * FROM test',
        tables: ['test'],
        fromMap: fromMap,
        singleResult: true,
      );

      final events = <dynamic>[];
      final sub = stream.listen((e) => events.add(e));

      controller.add(WatchResponse(
        json: jsonEncode({'id': 1, 'name': 'Alice'}),
        singleResult: true,
      ));

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(events.length, 1);
      expect(events[0], isA<_TestModel>());
      expect(events[0].id, 1);
    });

    test('singleResult emits single value without fromMap', () async {
      final controller = StreamController<WatchResponse>();
      final client = _createClientWithChannel(controller);

      final stream = client.watch(
        'SELECT COUNT(*) FROM test',
        tables: ['test'],
        singleResult: true,
      );

      final events = <dynamic>[];
      final sub = stream.listen((e) => events.add(e));

      controller.add(WatchResponse(
        json: jsonEncode(42),
        singleResult: true,
      ));

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(events, [42]);
    });

    test('passes request parameters to WatchRequest', () async {
      final controller = StreamController<WatchResponse>();
      final channel = _FakeChannel(controller);
      WatchRequest? capturedRequest;

      final fakeClient = _FakeWatchClient(channel, (req) {
        capturedRequest = req;
      });
      final client = SqliteWrapperGRPC.withHostAndPort(
          host: 'localhost', port: 50051);
      client.clientOverride = fakeClient;

      final stream = client.watch(
        'SELECT * FROM t',
        params: [1, 'test'],
        tables: ['t1', 't2'],
        singleResult: true,
        dbName: 'mydb',
      );

      final sub = stream.listen((_) {});

      await Future<void>.delayed(Duration.zero);

      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.sql, 'SELECT * FROM t');
      expect(capturedRequest!.dbName, 'mydb');
      expect(capturedRequest!.singleResult, isTrue);
      expect(capturedRequest!.tables, ['t1', 't2']);

      await sub.cancel();
      await controller.close();
    });

    test('stream error propagates', () async {
      final controller = StreamController<WatchResponse>();
      final client = _createClientWithChannel(controller);

      final stream = client.watch(
        'SELECT * FROM test',
        tables: ['test'],
      );

      final errors = <dynamic>[];
      final sub = stream.listen(
        (_) {},
        onError: (e) => errors.add(e),
      );

      controller.addError(Exception('test error'));

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await controller.close();

      expect(errors.length, 1);
      expect(errors[0].toString(), contains('test error'));
    });
  });
}

class _TestModel {
  final int id;
  final String name;
  _TestModel(this.id, this.name);
}

class _FakeWatchClient extends SqliteWrapperServiceClient {
  final void Function(WatchRequest) onWatch;

  _FakeWatchClient(super.channel, this.onWatch);

  @override
  grpc.ResponseStream<WatchResponse> watch(
    WatchRequest request, {
    grpc.CallOptions? options,
  }) {
    onWatch(request);
    return super.watch(request, options: options);
  }
}
