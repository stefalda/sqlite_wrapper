// This is a generated file - do not edit.
//
// Generated from sqlite_wrapper_rpc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum Param_Value {
  stringValue,
  intValue,
  doubleValue,
  boolValue,
  bytesValue,
  notSet
}

/// Compact parameter representation (replaces google.protobuf.Any).
class Param extends $pb.GeneratedMessage {
  factory Param({
    $core.String? stringValue,
    $fixnum.Int64? intValue,
    $core.double? doubleValue,
    $core.bool? boolValue,
    $core.List<$core.int>? bytesValue,
  }) {
    final result = create();
    if (stringValue != null) result.stringValue = stringValue;
    if (intValue != null) result.intValue = intValue;
    if (doubleValue != null) result.doubleValue = doubleValue;
    if (boolValue != null) result.boolValue = boolValue;
    if (bytesValue != null) result.bytesValue = bytesValue;
    return result;
  }

  Param._();

  factory Param.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Param.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Param_Value> _Param_ValueByTag = {
    1: Param_Value.stringValue,
    2: Param_Value.intValue,
    3: Param_Value.doubleValue,
    4: Param_Value.boolValue,
    5: Param_Value.bytesValue,
    0: Param_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Param',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'stringValue')
    ..aInt64(2, _omitFieldNames ? '' : 'intValue')
    ..aD(3, _omitFieldNames ? '' : 'doubleValue')
    ..aOB(4, _omitFieldNames ? '' : 'boolValue')
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'bytesValue', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Param clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Param copyWith(void Function(Param) updates) =>
      super.copyWith((message) => updates(message as Param)) as Param;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Param create() => Param._();
  @$core.override
  Param createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Param getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Param>(create);
  static Param? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  Param_Value whichValue() => _Param_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get intValue => $_getI64(1);
  @$pb.TagNumber(2)
  set intValue($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get bytesValue => $_getN(4);
  @$pb.TagNumber(5)
  set bytesValue($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBytesValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearBytesValue() => $_clearField(5);
}

enum Value_Value {
  stringValue,
  intValue,
  doubleValue,
  boolValue,
  bytesValue,
  notSet
}

/// A single value returned in query results.
class Value extends $pb.GeneratedMessage {
  factory Value({
    $core.String? stringValue,
    $fixnum.Int64? intValue,
    $core.double? doubleValue,
    $core.bool? boolValue,
    $core.List<$core.int>? bytesValue,
  }) {
    final result = create();
    if (stringValue != null) result.stringValue = stringValue;
    if (intValue != null) result.intValue = intValue;
    if (doubleValue != null) result.doubleValue = doubleValue;
    if (boolValue != null) result.boolValue = boolValue;
    if (bytesValue != null) result.bytesValue = bytesValue;
    return result;
  }

  Value._();

  factory Value.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Value.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Value_Value> _Value_ValueByTag = {
    1: Value_Value.stringValue,
    2: Value_Value.intValue,
    3: Value_Value.doubleValue,
    4: Value_Value.boolValue,
    5: Value_Value.bytesValue,
    0: Value_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Value',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'stringValue')
    ..aInt64(2, _omitFieldNames ? '' : 'intValue')
    ..aD(3, _omitFieldNames ? '' : 'doubleValue')
    ..aOB(4, _omitFieldNames ? '' : 'boolValue')
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'bytesValue', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Value clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Value copyWith(void Function(Value) updates) =>
      super.copyWith((message) => updates(message as Value)) as Value;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Value create() => Value._();
  @$core.override
  Value createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Value getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Value>(create);
  static Value? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  Value_Value whichValue() => _Value_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get intValue => $_getI64(1);
  @$pb.TagNumber(2)
  set intValue($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get bytesValue => $_getN(4);
  @$pb.TagNumber(5)
  set bytesValue($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBytesValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearBytesValue() => $_clearField(5);
}

/// A single column in a result row.
class Column extends $pb.GeneratedMessage {
  factory Column({
    $core.String? name,
    Value? value,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (value != null) result.value = value;
    return result;
  }

  Column._();

  factory Column.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Column.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Column',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Value>(2, _omitFieldNames ? '' : 'value', subBuilder: Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Column clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Column copyWith(void Function(Column) updates) =>
      super.copyWith((message) => updates(message as Column)) as Column;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Column create() => Column._();
  @$core.override
  Column createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Column getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Column>(create);
  static Column? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  Value get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
  @$pb.TagNumber(2)
  Value ensureValue() => $_ensure(1);
}

/// A single row of query results.
class Row extends $pb.GeneratedMessage {
  factory Row({
    $core.Iterable<Column>? columns,
  }) {
    final result = create();
    if (columns != null) result.columns.addAll(columns);
    return result;
  }

  Row._();

  factory Row.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Row.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Row',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..pPM<Column>(1, _omitFieldNames ? '' : 'columns',
        subBuilder: Column.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Row clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Row copyWith(void Function(Row) updates) =>
      super.copyWith((message) => updates(message as Row)) as Row;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Row create() => Row._();
  @$core.override
  Row createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Row getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Row>(create);
  static Row? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Column> get columns => $_getList(0);
}

class OpenDBRequest extends $pb.GeneratedMessage {
  factory OpenDBRequest({
    $core.int? version,
    $core.String? dbName,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (dbName != null) result.dbName = dbName;
    return result;
  }

  OpenDBRequest._();

  factory OpenDBRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpenDBRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenDBRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDBRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDBRequest copyWith(void Function(OpenDBRequest) updates) =>
      super.copyWith((message) => updates(message as OpenDBRequest))
          as OpenDBRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenDBRequest create() => OpenDBRequest._();
  @$core.override
  OpenDBRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OpenDBRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenDBRequest>(create);
  static OpenDBRequest? _defaultInstance;

  /// The target version (if needed for migration).
  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  /// An optional name for the database.
  @$pb.TagNumber(2)
  $core.String get dbName => $_getSZ(1);
  @$pb.TagNumber(2)
  set dbName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDbName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDbName() => $_clearField(2);
}

class OpenDBResponse extends $pb.GeneratedMessage {
  factory OpenDBResponse({
    $core.bool? created,
    $core.int? version,
    $core.String? sqliteVersion,
    $core.String? dbName,
  }) {
    final result = create();
    if (created != null) result.created = created;
    if (version != null) result.version = version;
    if (sqliteVersion != null) result.sqliteVersion = sqliteVersion;
    if (dbName != null) result.dbName = dbName;
    return result;
  }

  OpenDBResponse._();

  factory OpenDBResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpenDBResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenDBResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'created')
    ..aI(2, _omitFieldNames ? '' : 'version')
    ..aOS(3, _omitFieldNames ? '' : 'sqliteVersion', protoName: 'sqliteVersion')
    ..aOS(4, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDBResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenDBResponse copyWith(void Function(OpenDBResponse) updates) =>
      super.copyWith((message) => updates(message as OpenDBResponse))
          as OpenDBResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenDBResponse create() => OpenDBResponse._();
  @$core.override
  OpenDBResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OpenDBResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenDBResponse>(create);
  static OpenDBResponse? _defaultInstance;

  /// Indicates if the database was created (true) or already existed (false).
  @$pb.TagNumber(1)
  $core.bool get created => $_getBF(0);
  @$pb.TagNumber(1)
  set created($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCreated() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreated() => $_clearField(1);

  /// The version of the database.
  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  /// The SQLite engine version.
  @$pb.TagNumber(3)
  $core.String get sqliteVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set sqliteVersion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSqliteVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearSqliteVersion() => $_clearField(3);

  /// The database name.
  @$pb.TagNumber(4)
  $core.String get dbName => $_getSZ(3);
  @$pb.TagNumber(4)
  set dbName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDbName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDbName() => $_clearField(4);
}

class CloseDBRequest extends $pb.GeneratedMessage {
  factory CloseDBRequest({
    $core.String? dbName,
  }) {
    final result = create();
    if (dbName != null) result.dbName = dbName;
    return result;
  }

  CloseDBRequest._();

  factory CloseDBRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseDBRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseDBRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseDBRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseDBRequest copyWith(void Function(CloseDBRequest) updates) =>
      super.copyWith((message) => updates(message as CloseDBRequest))
          as CloseDBRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseDBRequest create() => CloseDBRequest._();
  @$core.override
  CloseDBRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CloseDBRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseDBRequest>(create);
  static CloseDBRequest? _defaultInstance;

  /// The name of the database to close.
  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => $_clearField(1);
}

class CloseDBResponse extends $pb.GeneratedMessage {
  factory CloseDBResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  CloseDBResponse._();

  factory CloseDBResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseDBResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseDBResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseDBResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseDBResponse copyWith(void Function(CloseDBResponse) updates) =>
      super.copyWith((message) => updates(message as CloseDBResponse))
          as CloseDBResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseDBResponse create() => CloseDBResponse._();
  @$core.override
  CloseDBResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CloseDBResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseDBResponse>(create);
  static CloseDBResponse? _defaultInstance;

  /// Indicates if the operation succeeded.
  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

/// Used for both executing commands (INSERT/UPDATE/DELETE) and queries.
class SqlQueryRequest extends $pb.GeneratedMessage {
  factory SqlQueryRequest({
    $core.String? sql,
    $core.Iterable<Param>? params,
    $core.String? dbName,
    $core.Iterable<$core.String>? tables,
  }) {
    final result = create();
    if (sql != null) result.sql = sql;
    if (params != null) result.params.addAll(params);
    if (dbName != null) result.dbName = dbName;
    if (tables != null) result.tables.addAll(tables);
    return result;
  }

  SqlQueryRequest._();

  factory SqlQueryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SqlQueryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SqlQueryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sql')
    ..pPM<Param>(2, _omitFieldNames ? '' : 'params', subBuilder: Param.create)
    ..aOS(3, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..pPS(4, _omitFieldNames ? '' : 'tables')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlQueryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlQueryRequest copyWith(void Function(SqlQueryRequest) updates) =>
      super.copyWith((message) => updates(message as SqlQueryRequest))
          as SqlQueryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SqlQueryRequest create() => SqlQueryRequest._();
  @$core.override
  SqlQueryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SqlQueryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SqlQueryRequest>(create);
  static SqlQueryRequest? _defaultInstance;

  /// The SQL statement to execute.
  @$pb.TagNumber(1)
  $core.String get sql => $_getSZ(0);
  @$pb.TagNumber(1)
  set sql($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSql() => $_has(0);
  @$pb.TagNumber(1)
  void clearSql() => $_clearField(1);

  /// Parameters for the SQL statement (compact oneof instead of Any).
  @$pb.TagNumber(2)
  $pb.PbList<Param> get params => $_getList(1);

  /// The database name to use.
  @$pb.TagNumber(3)
  $core.String get dbName => $_getSZ(2);
  @$pb.TagNumber(3)
  set dbName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDbName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDbName() => $_clearField(3);

  /// Tables that are watched/modified by this request.
  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get tables => $_getList(3);
}

class SqlQueryResponse extends $pb.GeneratedMessage {
  factory SqlQueryResponse({
    $core.Iterable<Row>? rows,
    Value? result,
  }) {
    final result$ = create();
    if (rows != null) result$.rows.addAll(rows);
    if (result != null) result$.result = result;
    return result$;
  }

  SqlQueryResponse._();

  factory SqlQueryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SqlQueryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SqlQueryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..pPM<Row>(1, _omitFieldNames ? '' : 'rows', subBuilder: Row.create)
    ..aOM<Value>(2, _omitFieldNames ? '' : 'result', subBuilder: Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlQueryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SqlQueryResponse copyWith(void Function(SqlQueryResponse) updates) =>
      super.copyWith((message) => updates(message as SqlQueryResponse))
          as SqlQueryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SqlQueryResponse create() => SqlQueryResponse._();
  @$core.override
  SqlQueryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SqlQueryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SqlQueryResponse>(create);
  static SqlQueryResponse? _defaultInstance;

  /// For SELECT: the resulting rows.
  @$pb.TagNumber(1)
  $pb.PbList<Row> get rows => $_getList(0);

  /// For INSERT/UPDATE/DELETE: a single scalar result
  /// (last_insert_rowid, changes, etc.).
  @$pb.TagNumber(2)
  Value get result => $_getN(1);
  @$pb.TagNumber(2)
  set result(Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResult() => $_has(1);
  @$pb.TagNumber(2)
  void clearResult() => $_clearField(2);
  @$pb.TagNumber(2)
  Value ensureResult() => $_ensure(1);
}

class BatchRequest extends $pb.GeneratedMessage {
  factory BatchRequest({
    $core.Iterable<SqlQueryRequest>? requests,
  }) {
    final result = create();
    if (requests != null) result.requests.addAll(requests);
    return result;
  }

  BatchRequest._();

  factory BatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..pPM<SqlQueryRequest>(1, _omitFieldNames ? '' : 'requests',
        subBuilder: SqlQueryRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchRequest copyWith(void Function(BatchRequest) updates) =>
      super.copyWith((message) => updates(message as BatchRequest))
          as BatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchRequest create() => BatchRequest._();
  @$core.override
  BatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchRequest>(create);
  static BatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SqlQueryRequest> get requests => $_getList(0);
}

class BatchResponse extends $pb.GeneratedMessage {
  factory BatchResponse({
    $core.Iterable<SqlQueryResponse>? responses,
  }) {
    final result = create();
    if (responses != null) result.responses.addAll(responses);
    return result;
  }

  BatchResponse._();

  factory BatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..pPM<SqlQueryResponse>(1, _omitFieldNames ? '' : 'responses',
        subBuilder: SqlQueryResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchResponse copyWith(void Function(BatchResponse) updates) =>
      super.copyWith((message) => updates(message as BatchResponse))
          as BatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchResponse create() => BatchResponse._();
  @$core.override
  BatchResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchResponse>(create);
  static BatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SqlQueryResponse> get responses => $_getList(0);
}

class WatchRequest extends $pb.GeneratedMessage {
  factory WatchRequest({
    $core.String? sql,
    $core.Iterable<Param>? params,
    $core.String? dbName,
    $core.Iterable<$core.String>? tables,
    $core.bool? singleResult,
  }) {
    final result = create();
    if (sql != null) result.sql = sql;
    if (params != null) result.params.addAll(params);
    if (dbName != null) result.dbName = dbName;
    if (tables != null) result.tables.addAll(tables);
    if (singleResult != null) result.singleResult = singleResult;
    return result;
  }

  WatchRequest._();

  factory WatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sql')
    ..pPM<Param>(2, _omitFieldNames ? '' : 'params', subBuilder: Param.create)
    ..aOS(3, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..pPS(4, _omitFieldNames ? '' : 'tables')
    ..aOB(5, _omitFieldNames ? '' : 'singleResult', protoName: 'singleResult')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchRequest copyWith(void Function(WatchRequest) updates) =>
      super.copyWith((message) => updates(message as WatchRequest))
          as WatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchRequest create() => WatchRequest._();
  @$core.override
  WatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchRequest>(create);
  static WatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sql => $_getSZ(0);
  @$pb.TagNumber(1)
  set sql($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSql() => $_has(0);
  @$pb.TagNumber(1)
  void clearSql() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Param> get params => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get dbName => $_getSZ(2);
  @$pb.TagNumber(3)
  set dbName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDbName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDbName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get tables => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get singleResult => $_getBF(4);
  @$pb.TagNumber(5)
  set singleResult($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSingleResult() => $_has(4);
  @$pb.TagNumber(5)
  void clearSingleResult() => $_clearField(5);
}

class WatchResponse extends $pb.GeneratedMessage {
  factory WatchResponse({
    $core.Iterable<Row>? rows,
    Value? result,
    $core.bool? singleResult,
  }) {
    final result$ = create();
    if (rows != null) result$.rows.addAll(rows);
    if (result != null) result$.result = result;
    if (singleResult != null) result$.singleResult = singleResult;
    return result$;
  }

  WatchResponse._();

  factory WatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..pPM<Row>(1, _omitFieldNames ? '' : 'rows', subBuilder: Row.create)
    ..aOM<Value>(2, _omitFieldNames ? '' : 'result', subBuilder: Value.create)
    ..aOB(3, _omitFieldNames ? '' : 'singleResult', protoName: 'singleResult')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchResponse copyWith(void Function(WatchResponse) updates) =>
      super.copyWith((message) => updates(message as WatchResponse))
          as WatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchResponse create() => WatchResponse._();
  @$core.override
  WatchResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchResponse>(create);
  static WatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Row> get rows => $_getList(0);

  @$pb.TagNumber(2)
  Value get result => $_getN(1);
  @$pb.TagNumber(2)
  set result(Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResult() => $_has(1);
  @$pb.TagNumber(2)
  void clearResult() => $_clearField(2);
  @$pb.TagNumber(2)
  Value ensureResult() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get singleResult => $_getBF(2);
  @$pb.TagNumber(3)
  set singleResult($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSingleResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearSingleResult() => $_clearField(3);
}

class GetVersionRequest extends $pb.GeneratedMessage {
  factory GetVersionRequest({
    $core.String? dbName,
  }) {
    final result = create();
    if (dbName != null) result.dbName = dbName;
    return result;
  }

  GetVersionRequest._();

  factory GetVersionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVersionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVersionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVersionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVersionRequest copyWith(void Function(GetVersionRequest) updates) =>
      super.copyWith((message) => updates(message as GetVersionRequest))
          as GetVersionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVersionRequest create() => GetVersionRequest._();
  @$core.override
  GetVersionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVersionRequest>(create);
  static GetVersionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => $_clearField(1);
}

class GetVersionResponse extends $pb.GeneratedMessage {
  factory GetVersionResponse({
    $core.int? version,
  }) {
    final result = create();
    if (version != null) result.version = version;
    return result;
  }

  GetVersionResponse._();

  factory GetVersionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVersionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVersionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVersionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVersionResponse copyWith(void Function(GetVersionResponse) updates) =>
      super.copyWith((message) => updates(message as GetVersionResponse))
          as GetVersionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVersionResponse create() => GetVersionResponse._();
  @$core.override
  GetVersionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVersionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVersionResponse>(create);
  static GetVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
}

class SetVersionRequest extends $pb.GeneratedMessage {
  factory SetVersionRequest({
    $core.String? dbName,
    $core.int? version,
  }) {
    final result = create();
    if (dbName != null) result.dbName = dbName;
    if (version != null) result.version = version;
    return result;
  }

  SetVersionRequest._();

  factory SetVersionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetVersionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetVersionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..aI(2, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetVersionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetVersionRequest copyWith(void Function(SetVersionRequest) updates) =>
      super.copyWith((message) => updates(message as SetVersionRequest))
          as SetVersionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetVersionRequest create() => SetVersionRequest._();
  @$core.override
  SetVersionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SetVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetVersionRequest>(create);
  static SetVersionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);
}

class SetVersionResponse extends $pb.GeneratedMessage {
  factory SetVersionResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  SetVersionResponse._();

  factory SetVersionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetVersionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetVersionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetVersionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetVersionResponse copyWith(void Function(SetVersionResponse) updates) =>
      super.copyWith((message) => updates(message as SetVersionResponse))
          as SetVersionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetVersionResponse create() => SetVersionResponse._();
  @$core.override
  SetVersionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SetVersionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetVersionResponse>(create);
  static SetVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class EchoRequest extends $pb.GeneratedMessage {
  factory EchoRequest({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  EchoRequest._();

  factory EchoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EchoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoRequest copyWith(void Function(EchoRequest) updates) =>
      super.copyWith((message) => updates(message as EchoRequest))
          as EchoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoRequest create() => EchoRequest._();
  @$core.override
  EchoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EchoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoRequest>(create);
  static EchoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class EchoResponse extends $pb.GeneratedMessage {
  factory EchoResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  EchoResponse._();

  factory EchoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EchoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoResponse copyWith(void Function(EchoResponse) updates) =>
      super.copyWith((message) => updates(message as EchoResponse))
          as EchoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoResponse create() => EchoResponse._();
  @$core.override
  EchoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EchoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoResponse>(create);
  static EchoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
