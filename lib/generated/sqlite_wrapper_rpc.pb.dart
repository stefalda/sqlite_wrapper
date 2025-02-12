//
//  Generated code. Do not modify.
//  source: sqlite_wrapper_rpc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/any.pb.dart' as $2;

class OpenDBRequest extends $pb.GeneratedMessage {
  factory OpenDBRequest({
    $core.String? path,
    $core.int? version,
    $core.String? dbName,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (version != null) {
      $result.version = version;
    }
    if (dbName != null) {
      $result.dbName = dbName;
    }
    return $result;
  }
  OpenDBRequest._() : super();
  factory OpenDBRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenDBRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenDBRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenDBRequest clone() => OpenDBRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenDBRequest copyWith(void Function(OpenDBRequest) updates) => super.copyWith((message) => updates(message as OpenDBRequest)) as OpenDBRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenDBRequest create() => OpenDBRequest._();
  OpenDBRequest createEmptyInstance() => create();
  static $pb.PbList<OpenDBRequest> createRepeated() => $pb.PbList<OpenDBRequest>();
  @$core.pragma('dart2js:noInline')
  static OpenDBRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenDBRequest>(create);
  static OpenDBRequest? _defaultInstance;

  /// The file path for the SQLite database.
  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  /// The target version (if needed for migration).
  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  /// An optional name for the database.
  @$pb.TagNumber(3)
  $core.String get dbName => $_getSZ(2);
  @$pb.TagNumber(3)
  set dbName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDbName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDbName() => clearField(3);
}

class OpenDBResponse extends $pb.GeneratedMessage {
  factory OpenDBResponse({
    $core.bool? created,
    $core.int? version,
    $core.String? sqliteVersion,
    $core.String? dbName,
    $core.String? path,
  }) {
    final $result = create();
    if (created != null) {
      $result.created = created;
    }
    if (version != null) {
      $result.version = version;
    }
    if (sqliteVersion != null) {
      $result.sqliteVersion = sqliteVersion;
    }
    if (dbName != null) {
      $result.dbName = dbName;
    }
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  OpenDBResponse._() : super();
  factory OpenDBResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenDBResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenDBResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'created')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'sqliteVersion', protoName: 'sqliteVersion')
    ..aOS(4, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..aOS(5, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenDBResponse clone() => OpenDBResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenDBResponse copyWith(void Function(OpenDBResponse) updates) => super.copyWith((message) => updates(message as OpenDBResponse)) as OpenDBResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenDBResponse create() => OpenDBResponse._();
  OpenDBResponse createEmptyInstance() => create();
  static $pb.PbList<OpenDBResponse> createRepeated() => $pb.PbList<OpenDBResponse>();
  @$core.pragma('dart2js:noInline')
  static OpenDBResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenDBResponse>(create);
  static OpenDBResponse? _defaultInstance;

  /// Indicates if the database was created (true) or already existed (false).
  @$pb.TagNumber(1)
  $core.bool get created => $_getBF(0);
  @$pb.TagNumber(1)
  set created($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreated() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreated() => clearField(1);

  /// The version of the database.
  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  /// The SQLite engine version.
  @$pb.TagNumber(3)
  $core.String get sqliteVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set sqliteVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSqliteVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearSqliteVersion() => clearField(3);

  /// The database name.
  @$pb.TagNumber(4)
  $core.String get dbName => $_getSZ(3);
  @$pb.TagNumber(4)
  set dbName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDbName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDbName() => clearField(4);

  /// The path to the database file.
  @$pb.TagNumber(5)
  $core.String get path => $_getSZ(4);
  @$pb.TagNumber(5)
  set path($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPath() => $_has(4);
  @$pb.TagNumber(5)
  void clearPath() => clearField(5);
}

class CloseDBRequest extends $pb.GeneratedMessage {
  factory CloseDBRequest({
    $core.String? dbName,
  }) {
    final $result = create();
    if (dbName != null) {
      $result.dbName = dbName;
    }
    return $result;
  }
  CloseDBRequest._() : super();
  factory CloseDBRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseDBRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseDBRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseDBRequest clone() => CloseDBRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseDBRequest copyWith(void Function(CloseDBRequest) updates) => super.copyWith((message) => updates(message as CloseDBRequest)) as CloseDBRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseDBRequest create() => CloseDBRequest._();
  CloseDBRequest createEmptyInstance() => create();
  static $pb.PbList<CloseDBRequest> createRepeated() => $pb.PbList<CloseDBRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseDBRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseDBRequest>(create);
  static CloseDBRequest? _defaultInstance;

  /// The name of the database to close.
  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => clearField(1);
}

class CloseDBResponse extends $pb.GeneratedMessage {
  factory CloseDBResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  CloseDBResponse._() : super();
  factory CloseDBResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseDBResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseDBResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseDBResponse clone() => CloseDBResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseDBResponse copyWith(void Function(CloseDBResponse) updates) => super.copyWith((message) => updates(message as CloseDBResponse)) as CloseDBResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseDBResponse create() => CloseDBResponse._();
  CloseDBResponse createEmptyInstance() => create();
  static $pb.PbList<CloseDBResponse> createRepeated() => $pb.PbList<CloseDBResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseDBResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseDBResponse>(create);
  static CloseDBResponse? _defaultInstance;

  /// Indicates if the operation succeeded.
  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

/// Used for both executing commands (INSERT/UPDATE/DELETE) and queries.
class SqlQueryRequest extends $pb.GeneratedMessage {
  factory SqlQueryRequest({
    $core.String? sql,
    $core.Iterable<$2.Any>? params,
    $core.String? dbName,
  }) {
    final $result = create();
    if (sql != null) {
      $result.sql = sql;
    }
    if (params != null) {
      $result.params.addAll(params);
    }
    if (dbName != null) {
      $result.dbName = dbName;
    }
    return $result;
  }
  SqlQueryRequest._() : super();
  factory SqlQueryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SqlQueryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SqlQueryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sql')
    ..pc<$2.Any>(2, _omitFieldNames ? '' : 'params', $pb.PbFieldType.PM, subBuilder: $2.Any.create)
    ..aOS(3, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SqlQueryRequest clone() => SqlQueryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SqlQueryRequest copyWith(void Function(SqlQueryRequest) updates) => super.copyWith((message) => updates(message as SqlQueryRequest)) as SqlQueryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SqlQueryRequest create() => SqlQueryRequest._();
  SqlQueryRequest createEmptyInstance() => create();
  static $pb.PbList<SqlQueryRequest> createRepeated() => $pb.PbList<SqlQueryRequest>();
  @$core.pragma('dart2js:noInline')
  static SqlQueryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SqlQueryRequest>(create);
  static SqlQueryRequest? _defaultInstance;

  /// The SQL statement to execute.
  @$pb.TagNumber(1)
  $core.String get sql => $_getSZ(0);
  @$pb.TagNumber(1)
  set sql($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSql() => $_has(0);
  @$pb.TagNumber(1)
  void clearSql() => clearField(1);

  /// Parameters for the SQL statement (passed as strings for simplicity).
  @$pb.TagNumber(2)
  $core.List<$2.Any> get params => $_getList(1);

  /// The database name to use.
  @$pb.TagNumber(3)
  $core.String get dbName => $_getSZ(2);
  @$pb.TagNumber(3)
  set dbName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDbName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDbName() => clearField(3);
}

class SqlQueryResponse extends $pb.GeneratedMessage {
  factory SqlQueryResponse({
    $core.String? result,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    return $result;
  }
  SqlQueryResponse._() : super();
  factory SqlQueryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SqlQueryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SqlQueryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'result')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SqlQueryResponse clone() => SqlQueryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SqlQueryResponse copyWith(void Function(SqlQueryResponse) updates) => super.copyWith((message) => updates(message as SqlQueryResponse)) as SqlQueryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SqlQueryResponse create() => SqlQueryResponse._();
  SqlQueryResponse createEmptyInstance() => create();
  static $pb.PbList<SqlQueryResponse> createRepeated() => $pb.PbList<SqlQueryResponse>();
  @$core.pragma('dart2js:noInline')
  static SqlQueryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SqlQueryResponse>(create);
  static SqlQueryResponse? _defaultInstance;

  /// For simplicity, the result is returned as a JSON-encoded string.
  /// In a real-world scenario you might define a more structured response.
  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

class GetVersionRequest extends $pb.GeneratedMessage {
  factory GetVersionRequest({
    $core.String? dbName,
  }) {
    final $result = create();
    if (dbName != null) {
      $result.dbName = dbName;
    }
    return $result;
  }
  GetVersionRequest._() : super();
  factory GetVersionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVersionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVersionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVersionRequest clone() => GetVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVersionRequest copyWith(void Function(GetVersionRequest) updates) => super.copyWith((message) => updates(message as GetVersionRequest)) as GetVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVersionRequest create() => GetVersionRequest._();
  GetVersionRequest createEmptyInstance() => create();
  static $pb.PbList<GetVersionRequest> createRepeated() => $pb.PbList<GetVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVersionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVersionRequest>(create);
  static GetVersionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => clearField(1);
}

class GetVersionResponse extends $pb.GeneratedMessage {
  factory GetVersionResponse({
    $core.int? version,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  GetVersionResponse._() : super();
  factory GetVersionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVersionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVersionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVersionResponse clone() => GetVersionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVersionResponse copyWith(void Function(GetVersionResponse) updates) => super.copyWith((message) => updates(message as GetVersionResponse)) as GetVersionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVersionResponse create() => GetVersionResponse._();
  GetVersionResponse createEmptyInstance() => create();
  static $pb.PbList<GetVersionResponse> createRepeated() => $pb.PbList<GetVersionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVersionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVersionResponse>(create);
  static GetVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
}

class SetVersionRequest extends $pb.GeneratedMessage {
  factory SetVersionRequest({
    $core.String? dbName,
    $core.int? version,
  }) {
    final $result = create();
    if (dbName != null) {
      $result.dbName = dbName;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  SetVersionRequest._() : super();
  factory SetVersionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetVersionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetVersionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetVersionRequest clone() => SetVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetVersionRequest copyWith(void Function(SetVersionRequest) updates) => super.copyWith((message) => updates(message as SetVersionRequest)) as SetVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetVersionRequest create() => SetVersionRequest._();
  SetVersionRequest createEmptyInstance() => create();
  static $pb.PbList<SetVersionRequest> createRepeated() => $pb.PbList<SetVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static SetVersionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetVersionRequest>(create);
  static SetVersionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dbName => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDbName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
}

class SetVersionResponse extends $pb.GeneratedMessage {
  factory SetVersionResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  SetVersionResponse._() : super();
  factory SetVersionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetVersionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetVersionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetVersionResponse clone() => SetVersionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetVersionResponse copyWith(void Function(SetVersionResponse) updates) => super.copyWith((message) => updates(message as SetVersionResponse)) as SetVersionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetVersionResponse create() => SetVersionResponse._();
  SetVersionResponse createEmptyInstance() => create();
  static $pb.PbList<SetVersionResponse> createRepeated() => $pb.PbList<SetVersionResponse>();
  @$core.pragma('dart2js:noInline')
  static SetVersionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetVersionResponse>(create);
  static SetVersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class WatchRequest extends $pb.GeneratedMessage {
  factory WatchRequest({
    $core.String? sql,
    $core.Iterable<$core.String>? params,
    $core.Iterable<$core.String>? tables,
    $core.bool? singleResult,
    $core.String? dbName,
  }) {
    final $result = create();
    if (sql != null) {
      $result.sql = sql;
    }
    if (params != null) {
      $result.params.addAll(params);
    }
    if (tables != null) {
      $result.tables.addAll(tables);
    }
    if (singleResult != null) {
      $result.singleResult = singleResult;
    }
    if (dbName != null) {
      $result.dbName = dbName;
    }
    return $result;
  }
  WatchRequest._() : super();
  factory WatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WatchRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sql')
    ..pPS(2, _omitFieldNames ? '' : 'params')
    ..pPS(3, _omitFieldNames ? '' : 'tables')
    ..aOB(4, _omitFieldNames ? '' : 'singleResult', protoName: 'singleResult')
    ..aOS(5, _omitFieldNames ? '' : 'dbName', protoName: 'dbName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WatchRequest clone() => WatchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WatchRequest copyWith(void Function(WatchRequest) updates) => super.copyWith((message) => updates(message as WatchRequest)) as WatchRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchRequest create() => WatchRequest._();
  WatchRequest createEmptyInstance() => create();
  static $pb.PbList<WatchRequest> createRepeated() => $pb.PbList<WatchRequest>();
  @$core.pragma('dart2js:noInline')
  static WatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchRequest>(create);
  static WatchRequest? _defaultInstance;

  /// The SQL query to watch.
  @$pb.TagNumber(1)
  $core.String get sql => $_getSZ(0);
  @$pb.TagNumber(1)
  set sql($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSql() => $_has(0);
  @$pb.TagNumber(1)
  void clearSql() => clearField(1);

  /// Optional parameters for the SQL statement.
  @$pb.TagNumber(2)
  $core.List<$core.String> get params => $_getList(1);

  /// List of tables to monitor for changes.
  @$pb.TagNumber(3)
  $core.List<$core.String> get tables => $_getList(2);

  /// Indicates whether the query returns a single result.
  @$pb.TagNumber(4)
  $core.bool get singleResult => $_getBF(3);
  @$pb.TagNumber(4)
  set singleResult($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSingleResult() => $_has(3);
  @$pb.TagNumber(4)
  void clearSingleResult() => clearField(4);

  /// The database name.
  @$pb.TagNumber(5)
  $core.String get dbName => $_getSZ(4);
  @$pb.TagNumber(5)
  set dbName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDbName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDbName() => clearField(5);
}

class WatchResponse extends $pb.GeneratedMessage {
  factory WatchResponse({
    $core.String? result,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    return $result;
  }
  WatchResponse._() : super();
  factory WatchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WatchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WatchResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'result')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WatchResponse clone() => WatchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WatchResponse copyWith(void Function(WatchResponse) updates) => super.copyWith((message) => updates(message as WatchResponse)) as WatchResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchResponse create() => WatchResponse._();
  WatchResponse createEmptyInstance() => create();
  static $pb.PbList<WatchResponse> createRepeated() => $pb.PbList<WatchResponse>();
  @$core.pragma('dart2js:noInline')
  static WatchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WatchResponse>(create);
  static WatchResponse? _defaultInstance;

  /// The result for the watched query (returned as a JSON-encoded string).
  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

class EchoRequest extends $pb.GeneratedMessage {
  factory EchoRequest({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  EchoRequest._() : super();
  factory EchoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EchoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EchoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EchoRequest clone() => EchoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EchoRequest copyWith(void Function(EchoRequest) updates) => super.copyWith((message) => updates(message as EchoRequest)) as EchoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoRequest create() => EchoRequest._();
  EchoRequest createEmptyInstance() => create();
  static $pb.PbList<EchoRequest> createRepeated() => $pb.PbList<EchoRequest>();
  @$core.pragma('dart2js:noInline')
  static EchoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoRequest>(create);
  static EchoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class EchoResponse extends $pb.GeneratedMessage {
  factory EchoResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  EchoResponse._() : super();
  factory EchoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EchoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EchoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sqlite_wrapper'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EchoResponse clone() => EchoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EchoResponse copyWith(void Function(EchoResponse) updates) => super.copyWith((message) => updates(message as EchoResponse)) as EchoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoResponse create() => EchoResponse._();
  EchoResponse createEmptyInstance() => create();
  static $pb.PbList<EchoResponse> createRepeated() => $pb.PbList<EchoResponse>();
  @$core.pragma('dart2js:noInline')
  static EchoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoResponse>(create);
  static EchoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
