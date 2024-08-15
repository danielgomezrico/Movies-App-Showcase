import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';

import 'package:http/http.dart' show ClientException;
import 'package:movie_flutter/common/result.dart';

mixin ResultToResponse {
  Result<T> toResult<T>(Response<T> response) {
    if (response.isSuccessful) {
      final body = response.body;
      if (body != null) {
        return Result.ok(body);
      }

      return Result.error('Response body is null or not of type $T');
    } else {
      final error = response.error;

      return Result.error(error);
    }
  }

  /// Do a request and return a [Result] with the response
  Future<Result<T>> handleResult<T>(
    Future<Result<T>> Function() doRequest,
  ) async {
    //TODO: improve error handling
    try {
      return await doRequest();

      // Ignore exists because of this issue https://github.com/google/built_value.dart/issues/1293
      // ignore: avoid_catching_errors
    } on DeserializationError catch (e) {
      return Result.error(e);
    } on FormatException catch (e) {
      return Result.error(e);
    } on TimeoutException catch (e) {
      return Result.error(e);
    } on SocketException catch (e) {
      return Result.error(e);
    } on HandshakeException catch (e) {
      return Result.error(e);
    } on ClientException catch (e) {
      return Result.error(e);
    }
  }

  /// Do a request and return a [Result] with the response
  Future<Result<T>> responseToResult<T>(
    Future<Response<T>> Function() doRequest,
  ) async {
    return handleResult(() async {
      final response = await doRequest();

      return toResult(response);
    });
  }
}
