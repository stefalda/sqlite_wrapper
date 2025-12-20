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
      '6': '.google.protobuf.Any',
      '10': 'params'
    },
    {'1': 'dbName', '3': 3, '4': 1, '5': 9, '10': 'dbName'},
  ],
};

/// Descriptor for `SqlQueryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sqlQueryRequestDescriptor = $convert.base64Decode(
    'Cg9TcWxRdWVyeVJlcXVlc3QSEAoDc3FsGAEgASgJUgNzcWwSLAoGcGFyYW1zGAIgAygLMhQuZ2'
    '9vZ2xlLnByb3RvYnVmLkFueVIGcGFyYW1zEhYKBmRiTmFtZRgDIAEoCVIGZGJOYW1l');

@$core.Deprecated('Use sqlQueryResponseDescriptor instead')
const SqlQueryResponse$json = {
  '1': 'SqlQueryResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `SqlQueryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sqlQueryResponseDescriptor = $convert
    .base64Decode('ChBTcWxRdWVyeVJlc3BvbnNlEhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0');

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
