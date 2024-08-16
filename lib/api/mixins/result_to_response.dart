import 'dart:async';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';

import 'package:http/http.dart' show ClientException;
import 'package:movie_flutter/common/log.dart';
import 'package:movie_flutter/common/result.dart';

mixin ResultToResponse {
  Future<Result<T>> responseToResult<T>(
    Future<Response<T>> Function() doRequest,
  ) async {
    return _handleResult(() async {
      final response = await doRequest();

      return _toResult(response);
    });
  }

  Result<T> _toResult<T>(Response<T> response) {
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
  Future<Result<T>> _handleResult<T>(
    Future<Result<T>> Function() doRequest,
  ) async {
    // TODO(danielgomezrico): improve error handling
    try {
      return await doRequest();

      // Ignore exists because of this issue https://github.com/google/built_value.dart/issues/1293
      // ignore: avoid_catching_errors
    } on DeserializationError catch (e, stack) {
      log.e('Error deserializing a response', error: e, stackTrace: stack);
      return Result.error('Error with our services, try again later');
    } on FormatException catch (e, stack) {
      log.e('Error formatting a response', error: e, stackTrace: stack);
      return Result.error('Error with our services, try again later');
    } on TimeoutException catch (_) {
      return Result.error('It looks like you do not have network connection.');
    } on SocketException catch (_) {
      return Result.error('It looks like you do not have network connection.');
    } on HandshakeException catch (_) {
      return Result.error('It looks like you do not have network connection.');
    } on ClientException catch (_) {
      return Result.error('It looks like you do not have network connection.');
    }
  }
}
