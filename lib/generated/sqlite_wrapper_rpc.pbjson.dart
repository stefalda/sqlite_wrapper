// This is a generated file - do not edit.
//
// Generated from sqlite_wrapper_rpc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use paramDescriptor instead')
const Param$json = {
  '1': 'Param',
  '2': [
    {'1': 'string_value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'int_value', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'intValue'},
    {'1': 'double_value', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'bool_value', '3': 4, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'bytes_value', '3': 5, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `Param`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paramDescriptor = $convert.base64Decode(
    'CgVQYXJhbRIjCgxzdHJpbmdfdmFsdWUYASABKAlIAFILc3RyaW5nVmFsdWUSHQoJaW50X3ZhbH'
    'VlGAIgASgDSABSCGludFZhbHVlEiMKDGRvdWJsZV92YWx1ZRgDIAEoAUgAUgtkb3VibGVWYWx1'
    'ZRIfCgpib29sX3ZhbHVlGAQgASgISABSCWJvb2xWYWx1ZRIhCgtieXRlc192YWx1ZRgFIAEoDE'
    'gAUgpieXRlc1ZhbHVlQgcKBXZhbHVl');

@$core.Deprecated('Use valueDescriptor instead')
const Value$json = {
  '1': 'Value',
  '2': [
    {'1': 'string_value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'int_value', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'intValue'},
    {'1': 'double_value', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'bool_value', '3': 4, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'bytes_value', '3': 5, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List valueDescriptor = $convert.base64Decode(
    'CgVWYWx1ZRIjCgxzdHJpbmdfdmFsdWUYASABKAlIAFILc3RyaW5nVmFsdWUSHQoJaW50X3ZhbH'
    'VlGAIgASgDSABSCGludFZhbHVlEiMKDGRvdWJsZV92YWx1ZRgDIAEoAUgAUgtkb3VibGVWYWx1'
    'ZRIfCgpib29sX3ZhbHVlGAQgASgISABSCWJvb2xWYWx1ZRIhCgtieXRlc192YWx1ZRgFIAEoDE'
    'gAUgpieXRlc1ZhbHVlQgcKBXZhbHVl');

@$core.Deprecated('Use columnDescriptor instead')
const Column$json = {
  '1': 'Column',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sqlite_wrapper.Value',
      '10': 'value'
    },
  ],
};

/// Descriptor for `Column`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List columnDescriptor = $convert.base64Decode(
    'CgZDb2x1bW4SEgoEbmFtZRgBIAEoCVIEbmFtZRIrCgV2YWx1ZRgCIAEoCzIVLnNxbGl0ZV93cm'
    'FwcGVyLlZhbHVlUgV2YWx1ZQ==');

@$core.Deprecated('Use rowDescriptor instead')
const Row$json = {
  '1': 'Row',
  '2': [
    {
      '1': 'columns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.Column',
      '10': 'columns'
    },
  ],
};

/// Descriptor for `Row`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rowDescriptor = $convert.base64Decode(
    'CgNSb3cSMAoHY29sdW1ucxgBIAMoCzIWLnNxbGl0ZV93cmFwcGVyLkNvbHVtblIHY29sdW1ucw'
    '==');

@$core.Deprecated('Use openDBRequestDescriptor instead')
const OpenDBRequest$json = {
  '1': 'OpenDBRequest',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 5, '10': 'version'},
    {'1': 'dbName', '3': 2, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `OpenDBRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openDBRequestDescriptor = $convert.base64Decode(
    'Cg1PcGVuREJSZXF1ZXN0EhgKB3ZlcnNpb24YASABKAVSB3ZlcnNpb24SFgoGZGJOYW1lGAIgAS'
    'gJUgZkYk5hbWU=');

@$core.Deprecated('Use openDBResponseDescriptor instead')
const OpenDBResponse$json = {
  '1': 'OpenDBResponse',
  '2': [
    {'1': 'created', '3': 1, '4': 1, '5': 8, '10': 'created'},
    {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    {'1': 'sqliteVersion', '3': 3, '4': 1, '5': 9, '10': 'sqliteVersion'},
    {'1': 'dbName', '3': 4, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `OpenDBResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openDBResponseDescriptor = $convert.base64Decode(
    'Cg5PcGVuREJSZXNwb25zZRIYCgdjcmVhdGVkGAEgASgIUgdjcmVhdGVkEhgKB3ZlcnNpb24YAi'
    'ABKAVSB3ZlcnNpb24SJAoNc3FsaXRlVmVyc2lvbhgDIAEoCVINc3FsaXRlVmVyc2lvbhIWCgZk'
    'Yk5hbWUYBCABKAlSBmRiTmFtZQ==');

@$core.Deprecated('Use closeDBRequestDescriptor instead')
const CloseDBRequest$json = {
  '1': 'CloseDBRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `CloseDBRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeDBRequestDescriptor = $convert
    .base64Decode('Cg5DbG9zZURCUmVxdWVzdBIWCgZkYk5hbWUYASABKAlSBmRiTmFtZQ==');

@$core.Deprecated('Use closeDBResponseDescriptor instead')
const CloseDBResponse$json = {
  '1': 'CloseDBResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CloseDBResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeDBResponseDescriptor = $convert.base64Decode(
    'Cg9DbG9zZURCUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use sqlQueryRequestDescriptor instead')
const SqlQueryRequest$json = {
  '1': 'SqlQueryRequest',
  '2': [
    {'1': 'sql', '3': 1, '4': 1, '5': 9, '10': 'sql'},
    {
      '1': 'params',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.Param',
      '10': 'params'
    },
    {'1': 'dbName', '3': 3, '4': 1, '5': 9, '10': 'dbName'},
    {'1': 'tables', '3': 4, '4': 3, '5': 9, '10': 'tables'},
  ],
};

/// Descriptor for `SqlQueryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sqlQueryRequestDescriptor = $convert.base64Decode(
    'Cg9TcWxRdWVyeVJlcXVlc3QSEAoDc3FsGAEgASgJUgNzcWwSLQoGcGFyYW1zGAIgAygLMhUuc3'
    'FsaXRlX3dyYXBwZXIuUGFyYW1SBnBhcmFtcxIWCgZkYk5hbWUYAyABKAlSBmRiTmFtZRIWCgZ0'
    'YWJsZXMYBCADKAlSBnRhYmxlcw==');

@$core.Deprecated('Use sqlQueryResponseDescriptor instead')
const SqlQueryResponse$json = {
  '1': 'SqlQueryResponse',
  '2': [
    {
      '1': 'rows',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.Row',
      '10': 'rows'
    },
    {
      '1': 'result',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sqlite_wrapper.Value',
      '10': 'result'
    },
  ],
};

/// Descriptor for `SqlQueryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sqlQueryResponseDescriptor = $convert.base64Decode(
    'ChBTcWxRdWVyeVJlc3BvbnNlEicKBHJvd3MYASADKAsyEy5zcWxpdGVfd3JhcHBlci5Sb3dSBH'
    'Jvd3MSLQoGcmVzdWx0GAIgASgLMhUuc3FsaXRlX3dyYXBwZXIuVmFsdWVSBnJlc3VsdA==');

@$core.Deprecated('Use batchRequestDescriptor instead')
const BatchRequest$json = {
  '1': 'BatchRequest',
  '2': [
    {
      '1': 'requests',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.SqlQueryRequest',
      '10': 'requests'
    },
  ],
};

/// Descriptor for `BatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchRequestDescriptor = $convert.base64Decode(
    'CgxCYXRjaFJlcXVlc3QSOwoIcmVxdWVzdHMYASADKAsyHy5zcWxpdGVfd3JhcHBlci5TcWxRdW'
    'VyeVJlcXVlc3RSCHJlcXVlc3Rz');

@$core.Deprecated('Use batchResponseDescriptor instead')
const BatchResponse$json = {
  '1': 'BatchResponse',
  '2': [
    {
      '1': 'responses',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.SqlQueryResponse',
      '10': 'responses'
    },
  ],
};

/// Descriptor for `BatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchResponseDescriptor = $convert.base64Decode(
    'Cg1CYXRjaFJlc3BvbnNlEj4KCXJlc3BvbnNlcxgBIAMoCzIgLnNxbGl0ZV93cmFwcGVyLlNxbF'
    'F1ZXJ5UmVzcG9uc2VSCXJlc3BvbnNlcw==');

@$core.Deprecated('Use watchRequestDescriptor instead')
const WatchRequest$json = {
  '1': 'WatchRequest',
  '2': [
    {'1': 'sql', '3': 1, '4': 1, '5': 9, '10': 'sql'},
    {
      '1': 'params',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.Param',
      '10': 'params'
    },
    {'1': 'dbName', '3': 3, '4': 1, '5': 9, '10': 'dbName'},
    {'1': 'tables', '3': 4, '4': 3, '5': 9, '10': 'tables'},
    {'1': 'singleResult', '3': 5, '4': 1, '5': 8, '10': 'singleResult'},
  ],
};

/// Descriptor for `WatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchRequestDescriptor = $convert.base64Decode(
    'CgxXYXRjaFJlcXVlc3QSEAoDc3FsGAEgASgJUgNzcWwSLQoGcGFyYW1zGAIgAygLMhUuc3FsaX'
    'RlX3dyYXBwZXIuUGFyYW1SBnBhcmFtcxIWCgZkYk5hbWUYAyABKAlSBmRiTmFtZRIWCgZ0YWJs'
    'ZXMYBCADKAlSBnRhYmxlcxIiCgxzaW5nbGVSZXN1bHQYBSABKAhSDHNpbmdsZVJlc3VsdA==');

@$core.Deprecated('Use watchResponseDescriptor instead')
const WatchResponse$json = {
  '1': 'WatchResponse',
  '2': [
    {
      '1': 'rows',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sqlite_wrapper.Row',
      '10': 'rows'
    },
    {
      '1': 'result',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sqlite_wrapper.Value',
      '10': 'result'
    },
    {'1': 'singleResult', '3': 3, '4': 1, '5': 8, '10': 'singleResult'},
  ],
};

/// Descriptor for `WatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchResponseDescriptor = $convert.base64Decode(
    'Cg1XYXRjaFJlc3BvbnNlEicKBHJvd3MYASADKAsyEy5zcWxpdGVfd3JhcHBlci5Sb3dSBHJvd3'
    'MSLQoGcmVzdWx0GAIgASgLMhUuc3FsaXRlX3dyYXBwZXIuVmFsdWVSBnJlc3VsdBIiCgxzaW5n'
    'bGVSZXN1bHQYAyABKAhSDHNpbmdsZVJlc3VsdA==');

@$core.Deprecated('Use getVersionRequestDescriptor instead')
const GetVersionRequest$json = {
  '1': 'GetVersionRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `GetVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVersionRequestDescriptor = $convert.base64Decode(
    'ChFHZXRWZXJzaW9uUmVxdWVzdBIWCgZkYk5hbWUYASABKAlSBmRiTmFtZQ==');

@$core.Deprecated('Use getVersionResponseDescriptor instead')
const GetVersionResponse$json = {
  '1': 'GetVersionResponse',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 5, '10': 'version'},
  ],
};

/// Descriptor for `GetVersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVersionResponseDescriptor =
    $convert.base64Decode(
        'ChJHZXRWZXJzaW9uUmVzcG9uc2USGAoHdmVyc2lvbhgBIAEoBVIHdmVyc2lvbg==');

@$core.Deprecated('Use setVersionRequestDescriptor instead')
const SetVersionRequest$json = {
  '1': 'SetVersionRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
    {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
  ],
};

/// Descriptor for `SetVersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setVersionRequestDescriptor = $convert.base64Decode(
    'ChFTZXRWZXJzaW9uUmVxdWVzdBIWCgZkYk5hbWUYASABKAlSBmRiTmFtZRIYCgd2ZXJzaW9uGA'
    'IgASgFUgd2ZXJzaW9u');

@$core.Deprecated('Use setVersionResponseDescriptor instead')
const SetVersionResponse$json = {
  '1': 'SetVersionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `SetVersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setVersionResponseDescriptor =
    $convert.base64Decode(
        'ChJTZXRWZXJzaW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use echoRequestDescriptor instead')
const EchoRequest$json = {
  '1': 'EchoRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoRequestDescriptor = $convert
    .base64Decode('CgtFY2hvUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use echoResponseDescriptor instead')
const EchoResponse$json = {
  '1': 'EchoResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoResponseDescriptor = $convert
    .base64Decode('CgxFY2hvUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use exportBackupRequestDescriptor instead')
const ExportBackupRequest$json = {
  '1': 'ExportBackupRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `ExportBackupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportBackupRequestDescriptor =
    $convert.base64Decode(
        'ChNFeHBvcnRCYWNrdXBSZXF1ZXN0EhYKBmRiTmFtZRgBIAEoCVIGZGJOYW1l');

@$core.Deprecated('Use exportBackupResponseDescriptor instead')
const ExportBackupResponse$json = {
  '1': 'ExportBackupResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ExportBackupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportBackupResponseDescriptor = $convert
    .base64Decode('ChRFeHBvcnRCYWNrdXBSZXNwb25zZRISCgRkYXRhGAEgASgMUgRkYXRh');

@$core.Deprecated('Use importBackupRequestDescriptor instead')
const ImportBackupRequest$json = {
  '1': 'ImportBackupRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ImportBackupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importBackupRequestDescriptor = $convert.base64Decode(
    'ChNJbXBvcnRCYWNrdXBSZXF1ZXN0EhYKBmRiTmFtZRgBIAEoCVIGZGJOYW1lEhIKBGRhdGEYAi'
    'ABKAxSBGRhdGE=');

@$core.Deprecated('Use importBackupResponseDescriptor instead')
const ImportBackupResponse$json = {
  '1': 'ImportBackupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ImportBackupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importBackupResponseDescriptor = $convert.base64Decode(
    'ChRJbXBvcnRCYWNrdXBSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use exportCSVRequestDescriptor instead')
const ExportCSVRequest$json = {
  '1': 'ExportCSVRequest',
  '2': [
    {'1': 'dbName', '3': 1, '4': 1, '5': 9, '10': 'dbName'},
    {'1': 'sql', '3': 2, '4': 1, '5': 9, '10': 'sql'},
  ],
};

/// Descriptor for `ExportCSVRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportCSVRequestDescriptor = $convert.base64Decode(
    'ChBFeHBvcnRDU1ZSZXF1ZXN0EhYKBmRiTmFtZRgBIAEoCVIGZGJOYW1lEhAKA3NxbBgCIAEoCV'
    'IDc3Fs');

@$core.Deprecated('Use exportCSVResponseDescriptor instead')
const ExportCSVResponse$json = {
  '1': 'ExportCSVResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ExportCSVResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportCSVResponseDescriptor = $convert
    .base64Decode('ChFFeHBvcnRDU1ZSZXNwb25zZRISCgRkYXRhGAEgASgMUgRkYXRh');
