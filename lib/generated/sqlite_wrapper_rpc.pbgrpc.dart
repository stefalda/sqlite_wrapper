// This is a generated file - do not edit.
//
// Generated from sqlite_wrapper_rpc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'sqlite_wrapper_rpc.pb.dart' as $0;

export 'sqlite_wrapper_rpc.pb.dart';

@$pb.GrpcServiceName('sqlite_wrapper.SqliteWrapperService')
class SqliteWrapperServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SqliteWrapperServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Opens (or creates) a database.
  $grpc.ResponseFuture<$0.OpenDBResponse> openDB(
    $0.OpenDBRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$openDB, request, options: options);
  }

  /// Closes an open database.
  $grpc.ResponseFuture<$0.CloseDBResponse> closeDB(
    $0.CloseDBRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$closeDB, request, options: options);
  }

  /// Executes a SQL command (such as INSERT, UPDATE, DELETE).
  $grpc.ResponseFuture<$0.SqlQueryResponse> execute(
    $0.SqlQueryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$execute, request, options: options);
  }

  /// Executes a SELECT query.
  $grpc.ResponseFuture<$0.SqlQueryResponse> select(
    $0.SqlQueryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  /// Executes a batch of SQL commands in a single round-trip.
  $grpc.ResponseFuture<$0.BatchResponse> executeBatch(
    $0.BatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$executeBatch, request, options: options);
  }

  /// Retrieves the database user_version.
  $grpc.ResponseFuture<$0.GetVersionResponse> getVersion(
    $0.GetVersionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVersion, request, options: options);
  }

  /// Sets the database user_version.
  $grpc.ResponseFuture<$0.SetVersionResponse> setVersion(
    $0.SetVersionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.EchoResponse> echo(
    $0.EchoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$echo, request, options: options);
  }

  /// Watches a query for real-time updates.
  /// This is a server-streaming RPC where the server will push new results.
  $grpc.ResponseStream<$0.WatchResponse> watch(
    $0.WatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$watch, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$openDB =
      $grpc.ClientMethod<$0.OpenDBRequest, $0.OpenDBResponse>(
          '/sqlite_wrapper.SqliteWrapperService/OpenDB',
          ($0.OpenDBRequest value) => value.writeToBuffer(),
          $0.OpenDBResponse.fromBuffer);
  static final _$closeDB =
      $grpc.ClientMethod<$0.CloseDBRequest, $0.CloseDBResponse>(
          '/sqlite_wrapper.SqliteWrapperService/CloseDB',
          ($0.CloseDBRequest value) => value.writeToBuffer(),
          $0.CloseDBResponse.fromBuffer);
  static final _$execute =
      $grpc.ClientMethod<$0.SqlQueryRequest, $0.SqlQueryResponse>(
          '/sqlite_wrapper.SqliteWrapperService/Execute',
          ($0.SqlQueryRequest value) => value.writeToBuffer(),
          $0.SqlQueryResponse.fromBuffer);
  static final _$select =
      $grpc.ClientMethod<$0.SqlQueryRequest, $0.SqlQueryResponse>(
          '/sqlite_wrapper.SqliteWrapperService/Select',
          ($0.SqlQueryRequest value) => value.writeToBuffer(),
          $0.SqlQueryResponse.fromBuffer);
  static final _$executeBatch =
      $grpc.ClientMethod<$0.BatchRequest, $0.BatchResponse>(
          '/sqlite_wrapper.SqliteWrapperService/ExecuteBatch',
          ($0.BatchRequest value) => value.writeToBuffer(),
          $0.BatchResponse.fromBuffer);
  static final _$getVersion =
      $grpc.ClientMethod<$0.GetVersionRequest, $0.GetVersionResponse>(
          '/sqlite_wrapper.SqliteWrapperService/GetVersion',
          ($0.GetVersionRequest value) => value.writeToBuffer(),
          $0.GetVersionResponse.fromBuffer);
  static final _$setVersion =
      $grpc.ClientMethod<$0.SetVersionRequest, $0.SetVersionResponse>(
          '/sqlite_wrapper.SqliteWrapperService/SetVersion',
          ($0.SetVersionRequest value) => value.writeToBuffer(),
          $0.SetVersionResponse.fromBuffer);
  static final _$echo = $grpc.ClientMethod<$0.EchoRequest, $0.EchoResponse>(
      '/sqlite_wrapper.SqliteWrapperService/Echo',
      ($0.EchoRequest value) => value.writeToBuffer(),
      $0.EchoResponse.fromBuffer);
  static final _$watch = $grpc.ClientMethod<$0.WatchRequest, $0.WatchResponse>(
      '/sqlite_wrapper.SqliteWrapperService/Watch',
      ($0.WatchRequest value) => value.writeToBuffer(),
      $0.WatchResponse.fromBuffer);
}

@$pb.GrpcServiceName('sqlite_wrapper.SqliteWrapperService')
abstract class SqliteWrapperServiceBase extends $grpc.Service {
  $core.String get $name => 'sqlite_wrapper.SqliteWrapperService';

  SqliteWrapperServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.OpenDBRequest, $0.OpenDBResponse>(
        'OpenDB',
        openDB_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OpenDBRequest.fromBuffer(value),
        ($0.OpenDBResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseDBRequest, $0.CloseDBResponse>(
        'CloseDB',
        closeDB_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CloseDBRequest.fromBuffer(value),
        ($0.CloseDBResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SqlQueryRequest, $0.SqlQueryResponse>(
        'Execute',
        execute_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SqlQueryRequest.fromBuffer(value),
        ($0.SqlQueryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SqlQueryRequest, $0.SqlQueryResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SqlQueryRequest.fromBuffer(value),
        ($0.SqlQueryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchRequest, $0.BatchResponse>(
        'ExecuteBatch',
        executeBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BatchRequest.fromBuffer(value),
        ($0.BatchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVersionRequest, $0.GetVersionResponse>(
        'GetVersion',
        getVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetVersionRequest.fromBuffer(value),
        ($0.GetVersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetVersionRequest, $0.SetVersionResponse>(
        'SetVersion',
        setVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetVersionRequest.fromBuffer(value),
        ($0.SetVersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EchoRequest, $0.EchoResponse>(
        'Echo',
        echo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EchoRequest.fromBuffer(value),
        ($0.EchoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WatchRequest, $0.WatchResponse>(
        'Watch',
        watch_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.WatchRequest.fromBuffer(value),
        ($0.WatchResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.OpenDBResponse> openDB_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.OpenDBRequest> $request) async {
    return openDB($call, await $request);
  }

  $async.Future<$0.OpenDBResponse> openDB(
      $grpc.ServiceCall call, $0.OpenDBRequest request);

  $async.Future<$0.CloseDBResponse> closeDB_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CloseDBRequest> $request) async {
    return closeDB($call, await $request);
  }

  $async.Future<$0.CloseDBResponse> closeDB(
      $grpc.ServiceCall call, $0.CloseDBRequest request);

  $async.Future<$0.SqlQueryResponse> execute_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SqlQueryRequest> $request) async {
    return execute($call, await $request);
  }

  $async.Future<$0.SqlQueryResponse> execute(
      $grpc.ServiceCall call, $0.SqlQueryRequest request);

  $async.Future<$0.SqlQueryResponse> select_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SqlQueryRequest> $request) async {
    return select($call, await $request);
  }

  $async.Future<$0.SqlQueryResponse> select(
      $grpc.ServiceCall call, $0.SqlQueryRequest request);

  $async.Future<$0.BatchResponse> executeBatch_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.BatchRequest> $request) async {
    return executeBatch($call, await $request);
  }

  $async.Future<$0.BatchResponse> executeBatch(
      $grpc.ServiceCall call, $0.BatchRequest request);

  $async.Future<$0.GetVersionResponse> getVersion_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetVersionRequest> $request) async {
    return getVersion($call, await $request);
  }

  $async.Future<$0.GetVersionResponse> getVersion(
      $grpc.ServiceCall call, $0.GetVersionRequest request);

  $async.Future<$0.SetVersionResponse> setVersion_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SetVersionRequest> $request) async {
    return setVersion($call, await $request);
  }

  $async.Future<$0.SetVersionResponse> setVersion(
      $grpc.ServiceCall call, $0.SetVersionRequest request);

  $async.Future<$0.EchoResponse> echo_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EchoRequest> $request) async {
    return echo($call, await $request);
  }

  $async.Future<$0.EchoResponse> echo(
      $grpc.ServiceCall call, $0.EchoRequest request);

  $async.Stream<$0.WatchResponse> watch_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.WatchRequest> $request) async* {
    yield* watch($call, await $request);
  }

  $async.Stream<$0.WatchResponse> watch(
      $grpc.ServiceCall call, $0.WatchRequest request);
}
