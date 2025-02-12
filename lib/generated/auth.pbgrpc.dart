//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $1;

export 'auth.pb.dart';

@$pb.GrpcServiceName('auth.AuthService')
class AuthServiceClient extends $grpc.Client {
  static final _$register = $grpc.ClientMethod<$1.RegisterRequest, $1.AuthResponse>(
      '/auth.AuthService/Register',
      ($1.RegisterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AuthResponse.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$1.LoginRequest, $1.AuthResponse>(
      '/auth.AuthService/Login',
      ($1.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AuthResponse.fromBuffer(value));
  static final _$validateToken = $grpc.ClientMethod<$1.ValidateTokenRequest, $1.ValidateTokenResponse>(
      '/auth.AuthService/ValidateToken',
      ($1.ValidateTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ValidateTokenResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.AuthResponse> register($1.RegisterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$1.AuthResponse> login($1.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateTokenResponse> validateToken($1.ValidateTokenRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateToken, request, options: options);
  }
}

@$pb.GrpcServiceName('auth.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.RegisterRequest, $1.AuthResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RegisterRequest.fromBuffer(value),
        ($1.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.LoginRequest, $1.AuthResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.LoginRequest.fromBuffer(value),
        ($1.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateTokenRequest, $1.ValidateTokenResponse>(
        'ValidateToken',
        validateToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ValidateTokenRequest.fromBuffer(value),
        ($1.ValidateTokenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.AuthResponse> register_Pre($grpc.ServiceCall call, $async.Future<$1.RegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$1.AuthResponse> login_Pre($grpc.ServiceCall call, $async.Future<$1.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$1.ValidateTokenResponse> validateToken_Pre($grpc.ServiceCall call, $async.Future<$1.ValidateTokenRequest> request) async {
    return validateToken(call, await request);
  }

  $async.Future<$1.AuthResponse> register($grpc.ServiceCall call, $1.RegisterRequest request);
  $async.Future<$1.AuthResponse> login($grpc.ServiceCall call, $1.LoginRequest request);
  $async.Future<$1.ValidateTokenResponse> validateToken($grpc.ServiceCall call, $1.ValidateTokenRequest request);
}
