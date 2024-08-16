import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// src: https://github.com/JosephNK/chopper/blob/ca778fd32bb87ad3241fcdd8119da64f58c29e72/chopper/lib/src/interceptor.dart#L136-L169
class LogCurlRequestInterceptor implements Interceptor {
  const LogCurlRequestInterceptor(this._logger);

  final Logger _logger;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final baseRequest = await chain.request.toBaseRequest();
    final curlParts = ['curl -v -X ${baseRequest.method}'];

    for (final header in baseRequest.headers.entries) {
      if (header.key == 'Authorization') {
        curlParts.add("-H '${header.key}: ***'");
      } else {
        curlParts.add("-H '${header.key}: ${header.value}'");
      }
    }

    if (baseRequest is http.Request) {
      final body = baseRequest.body;
      if (body.isNotEmpty) {
        curlParts.add("-d '$body'");
      }
    }

    if (baseRequest is http.MultipartRequest) {
      for (final field in baseRequest.fields.entries) {
        curlParts.add("-f '${field.key}: ${field.value}'");
      }
      for (final file in baseRequest.files) {
        curlParts.add("-f '${file.field}: ${file.filename ?? ''}'");
      }
    }

    curlParts.add('"${baseRequest.url}"');

    final message = curlParts.join(' ');
    // prints the request in chunks of 1000 chars
    final messages = _divide(message, 1000);
    for (final msg in messages) {
      _logger.d('[http] $msg');
    }

    return chain.proceed(chain.request);
  }

  List<String> _divide(String text, int chunkSize) {
    final result = <String>[];
    for (var i = 0; i < text.length; i += chunkSize) {
      result.add(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }

    return result;
  }
}
