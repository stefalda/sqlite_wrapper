import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:sqlite_wrapper/grpc/authentication_interceptor.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class GrpcServiceManager {
  late final GrpcOrGrpcWebClientChannel _channel;

  String? token;
  // Lazy-initialized service clients
  AuthClient? _authClient;
  SqliteWrapperServiceClient? _sqliteClient;

  GrpcServiceManager({
    String host = 'localhost',
    int port = 50051,
    bool secure = false,
  }) {
    final credentials = secure
        ? ChannelCredentials.secure()
        : ChannelCredentials.insecure();

    if (isRunningOnWeb()) {
      // gRPC-web: browser gestisce già la compressione HTTP,
      // .grpc() non è supportato su web.
      _channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: host,
        port: port,
        transportSecure: secure,
      );
    } else {
      // Native: abilita codecRegistry per decomprimere le risposte.
      _channel = GrpcOrGrpcWebClientChannel.grpc(
        host,
        port: port,
        options: ChannelOptions(
          credentials: credentials,
          codecRegistry: CodecRegistry(codecs: [GzipCodec()]),
        ),
      );
    }
  }

  // Getter methods that lazy-initialize clients
  AuthClient get authClient => _authClient ??= AuthClient(_channel);

  SqliteWrapperServiceClient get sqliteService =>
      _sqliteClient ??= SqliteWrapperServiceClient(_channel,
          interceptors: [AuthInterceptor(getToken)],
          options: CallOptions(compression: GzipCodec()));

  String? getToken() {
    return token;
  }

  // Method to add auth token to requests
  // CallOptions? getAuthOptions(String? token) {
  //   if (token == null) return null;
  //   return CallOptions(metadata: {
  //     'authorization': 'Bearer $token',
  //   });
  // }

  // Important: Shutdown the channel when done
  Future<void> dispose() async {
    await _channel.shutdown();
  }
}
