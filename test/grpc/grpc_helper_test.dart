import 'package:sqlite_wrapper/generated/google/protobuf/wrappers.pb.dart';
import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:test/test.dart';

void main() {
  group('convertParamsToAny', () {
    test('converts null', () async {
      final result = convertParamsToAny([null]).toList();
      expect(result.length, 1);
      expect(result[0].typeUrl, isEmpty);
    });

    test('converts int', () async {
      final result = convertParamsToAny([42]).toList();
      expect(result.length, 1);
      final unpacked = Int64Value();
      result[0].unpackInto(unpacked);
      expect(unpacked.value.toInt(), 42);
    });

    test('converts String', () async {
      final result = convertParamsToAny(['hello']).toList();
      expect(result.length, 1);
      final unpacked = StringValue();
      result[0].unpackInto(unpacked);
      expect(unpacked.value, 'hello');
    });

    test('converts double', () async {
      final result = convertParamsToAny([3.14]).toList();
      expect(result.length, 1);
      final unpacked = DoubleValue();
      result[0].unpackInto(unpacked);
      expect(unpacked.value, closeTo(3.14, 0.001));
    });

    test('converts bool', () async {
      final result = convertParamsToAny([true]).toList();
      expect(result.length, 1);
      final unpacked = BoolValue();
      result[0].unpackInto(unpacked);
      expect(unpacked.value, true);
    });

    test('throws on unsupported type', () {
      expect(
        () => convertParamsToAny([Object()]),
        throwsArgumentError,
      );
    });

    test('round-trip conversion via WatchRequest', () async {
      final params = <Object?>[null, 42, 'text', 2.5, false];
      final anyParams = convertParamsToAny(params).toList();

      expect(anyParams.length, 5);

      expect(anyParams[0].typeUrl, isEmpty);

      final intVal = Int64Value();
      anyParams[1].unpackInto(intVal);
      expect(intVal.value.toInt(), 42);

      final strVal = StringValue();
      anyParams[2].unpackInto(strVal);
      expect(strVal.value, 'text');

      final dblVal = DoubleValue();
      anyParams[3].unpackInto(dblVal);
      expect(dblVal.value, closeTo(2.5, 0.001));

      final boolVal = BoolValue();
      anyParams[4].unpackInto(boolVal);
      expect(boolVal.value, false);
    });
  });
}
