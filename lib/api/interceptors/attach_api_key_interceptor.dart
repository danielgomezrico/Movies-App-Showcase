import 'dart:async';

import 'package:chopper/chopper.dart';

class AttachApiKeyInterceptor implements Interceptor {
  const AttachApiKeyInterceptor(this._apiKey);

  final String _apiKey;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final request = applyHeader(chain.request, 'api_key', _apiKey);

    final interceptedRequest = request.copyWith(parameters: {
      ...request.parameters,
      'api_key': _apiKey,
    });

    return chain.proceed(interceptedRequest);
  }
}
