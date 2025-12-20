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

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    $core.Iterable<$1.Any>? params,
    $core.String? dbName,
  }) {
    final result = create();
    if (sql != null) result.sql = sql;
    if (params != null) result.params.addAll(params);
    if (dbName != null) result.dbName = dbName;
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
    ..pPM<$1.Any>(2, _omitFieldNames ? '' : 'params', subBuilder: $1.Any.create)
    ..aOS(3, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
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

  /// Parameters for the SQL statement (passed as strings for simplicity).
  @$pb.TagNumber(2)
  $pb.PbList<$1.Any> get params => $_getList(1);

  /// The database name to use.
  @$pb.TagNumber(3)
  $core.String get dbName => $_getSZ(2);
  @$pb.TagNumber(3)
  set dbName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDbName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDbName() => $_clearField(3);
}

class SqlQueryResponse extends $pb.GeneratedMessage {
  factory SqlQueryResponse({
    $core.String? result,
  }) {
    final result$ = create();
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
    ..aOS(1, _omitFieldNames ? '' : 'result')
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

  /// For simplicity, the result is returned as a JSON-encoded string.
  /// In a real-world scenario you might define a more structured response.
  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
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
