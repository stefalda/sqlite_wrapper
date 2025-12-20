import 'package:fixnum/fixnum.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/any.pb.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/wrappers.pb.dart';

/// Convert params to Any type
List<Any> convertParamsToAny(List params) {
  return params.map((value) {
    if (value is int) {
      return Any.pack(Int64Value()..value = Int64(value));
    } else if (value is String) {
      return Any.pack(StringValue()..value = value);
    } else if (value is bool) {
      return Any.pack(BoolValue()..value = value);
    } else if (value is double) {
      return Any.pack(DoubleValue()..value = value);
    } else if (value == null) {
      return Any();
    }
    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }).toList();
}
