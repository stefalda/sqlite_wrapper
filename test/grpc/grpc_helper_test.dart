import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:test/test.dart';

void main() {
  group('convertParamsToParam', () {
    test('converts null', () async {
      final result = convertParamsToParam([null]).toList();
      expect(result.length, 1);
      expect(result[0].whichValue(), Param_Value.notSet);
    });

    test('converts int', () async {
      final result = convertParamsToParam([42]).toList();
      expect(result.length, 1);
      expect(result[0].intValue, Int64(42));
    });

    test('converts String', () async {
      final result = convertParamsToParam(['hello']).toList();
      expect(result.length, 1);
      expect(result[0].stringValue, 'hello');
    });

    test('converts double', () async {
      final result = convertParamsToParam([3.14]).toList();
      expect(result.length, 1);
      expect(result[0].doubleValue, closeTo(3.14, 0.001));
    });

    test('converts bool', () async {
      final result = convertParamsToParam([true]).toList();
      expect(result.length, 1);
      expect(result[0].boolValue, isTrue);
    });

    test('converts bytes', () async {
      final result = convertParamsToParam([Uint8List.fromList([1, 2, 3])]).toList();
      expect(result.length, 1);
      expect(result[0].bytesValue, [1, 2, 3]);
    });

    test('throws on unsupported type', () {
      expect(
        () => convertParamsToParam([Object()]),
        throwsArgumentError,
      );
    });

    test('round-trip conversion via unpackParams', () async {
      final params = <Object?>[null, 42, 'text', 2.5, false, Uint8List.fromList([1, 2])];
      final paramMessages = convertParamsToParam(params).toList();
      expect(paramMessages.length, 6);

      final unpacked = unpackParams(paramMessages);
      expect(unpacked[0], isNull);
      expect(unpacked[1], 42);
      expect(unpacked[2], 'text');
      expect(unpacked[3], closeTo(2.5, 0.001));
      expect(unpacked[4], false);
      expect(unpacked[5], [1, 2]);
    });
  });

  group('dartFromValue / valueFromDart', () {
    test('round-trip int', () {
      final v = valueFromDart(42);
      expect(dartFromValue(v), 42);
    });

    test('round-trip string', () {
      final v = valueFromDart('hello');
      expect(dartFromValue(v), 'hello');
    });

    test('round-trip double', () {
      final v = valueFromDart(3.14);
      expect(dartFromValue(v), closeTo(3.14, 0.001));
    });

    test('round-trip bool', () {
      final v = valueFromDart(true);
      expect(dartFromValue(v), true);
    });

    test('round-trip bytes', () {
      final v = valueFromDart(Uint8List.fromList([1, 2, 3]));
      expect(dartFromValue(v), [1, 2, 3]);
    });
  });

  group('rowsFromMaps / mapsFromRows', () {
    test('round-trip list of maps', () {
      final maps = [
        {'id': 1, 'name': 'Alice'},
        {'id': 2, 'name': 'Bob'},
      ];
      final rows = rowsFromMaps(maps);
      final result = mapsFromRows(rows);
      expect(result, maps);
    });

    test('handles empty list', () {
      expect(rowsFromMaps([]), isEmpty);
      expect(mapsFromRows([]), isEmpty);
    });
  });
}
