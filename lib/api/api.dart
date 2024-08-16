import 'package:chopper/chopper.dart';
import 'package:movie_flutter/api/interceptors/attach_api_key_header_interceptor.dart';
import 'package:movie_flutter/api/repositories/movies_remote_service.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/api/serializers.dart';
import 'package:movie_flutter/api/serializers/built_value_converter.dart';
import 'package:movie_flutter/common/di/common_module.dart';
import 'package:movie_flutter/common/log.dart';

import 'interceptors/log_curl_request_interceptor.dart';

class Api {
  const Api._();

  factory Api.instance() {
    return _apiInstance ??= const Api._();
  }

  static Api? _apiInstance;

  static ChopperClient? _instance;

  static void setup(Uri baseUrl) {
    _instance = ChopperClient(
      baseUrl: baseUrl,
      converter: BuiltValueConverter(serializers),
      services: [
        MoviesRemoteService.create(),
      ],
      interceptors: [
        AttachApiKeyInterceptor(CommonModule.config().apiKey()),
        LogCurlRequestInterceptor(log),
      ],
    );
  }

  static T _getService<T extends ChopperService>() {
    if (_instance == null) throw Exception('Api not initialized');

    return _instance!.getService<T>();
  }

  static MoviesRepository moviesRepository() {
    return MoviesRepository(_getService<MoviesRemoteService>());
  }
}
