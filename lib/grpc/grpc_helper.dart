import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:sqlite_wrapper/generated/sqlite_wrapper_rpc.pb.dart';

/// Convert params to Param (compact oneof) type
Iterable<Param> convertParamsToParam(List<Object?> params) {
  return params.map((value) {
    if (value is int) {
      return Param(intValue: Int64(value));
    } else if (value is String) {
      return Param(stringValue: value);
    } else if (value is bool) {
      return Param(boolValue: value);
    } else if (value is double) {
      return Param(doubleValue: value);
    } else if (value is Uint8List) {
      return Param(bytesValue: value);
    } else if (value == null) {
      return Param();
    }
    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }).toList();
}

/// Unpack a repeated Param list back to Dart Object? list.
List<Object?> unpackParams(List<Param> params) {
  return params.map((param) {
    switch (param.whichValue()) {
      case Param_Value.stringValue:
        return param.stringValue;
      case Param_Value.intValue:
        return param.intValue.toInt();
      case Param_Value.doubleValue:
        return param.doubleValue;
      case Param_Value.boolValue:
        return param.boolValue;
      case Param_Value.bytesValue:
        return param.bytesValue as Uint8List;
      case Param_Value.notSet:
        return null;
    }
  }).toList();
}

/// Wrap a Dart value into a protobuf Value.
Value valueFromDart(Object? value) {
  if (value is int) return Value(intValue: Int64(value));
  if (value is String) return Value(stringValue: value);
  if (value is bool) return Value(boolValue: value);
  if (value is double) return Value(doubleValue: value);
  if (value is Uint8List) return Value(bytesValue: value);
  throw ArgumentError('Unsupported type: ${value.runtimeType}');
}

/// Unwrap a protobuf Value to a Dart value.
Object? dartFromValue(Value value) {
  switch (value.whichValue()) {
    case Value_Value.stringValue:
      return value.stringValue;
    case Value_Value.intValue:
      return value.intValue.toInt();
    case Value_Value.doubleValue:
      return value.doubleValue;
    case Value_Value.boolValue:
      return value.boolValue;
    case Value_Value.bytesValue:
      return value.bytesValue as Uint8List;
    case Value_Value.notSet:
      return null;
  }
}

/// Convert a list of Maps (from DatabaseCore.select) to a list of protobuf Rows.
List<Row> rowsFromMaps(List<Map<String, dynamic>> maps) {
  return maps.map((map) {
    final columns = map.entries.map((entry) {
      return Column(name: entry.key, value: valueFromDart(entry.value));
    }).toList();
    return Row(columns: columns);
  }).toList();
}

/// Convert a list of protobuf Rows back to a list of Maps.
List<Map<String, dynamic>> mapsFromRows(List<Row> rows) {
  return rows.map((row) {
    final map = <String, dynamic>{};
    for (final col in row.columns) {
      map[col.name] = dartFromValue(col.value);
    }
    return map;
  }).toList();
}
