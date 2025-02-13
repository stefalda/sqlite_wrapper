import 'package:grpc/grpc.dart';

//typedef function injectToken(Map<String, String> metadata, String uri);
typedef GetToken = String? Function();

class AuthInterceptor implements ClientInterceptor {
  final GetToken getToken;
  AuthInterceptor(this.getToken);

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final modifiedOptions = options.mergedWith(
      CallOptions(
        providers: [
          _injectToken, // method signatures match, so we should be ok
        ],
      ),
    );
    return invoker(method, requests, modifiedOptions);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    var newOptions = options.mergedWith(CallOptions(metadata: <String, String>{
      'token': getToken() ?? "",
    }));

    return invoker(method, request, newOptions);
    /*
    final modifiedOptions = options.mergedWith(
      CallOptions(
        providers: [
          (Map<String, String> metadata, String uri) {
            return _injectToken(metadata, uri);
          },
        ],
      ),
    );
    return super.interceptUnary(method, request, options, invoker);*/
  }

  Future<void> _injectToken(Map<String, String> metadata, String uri) async {
    metadata['token'] = getToken() ?? "";
    metadata['request_time'] = DateTime.now().toIso8601String();
  }
}
