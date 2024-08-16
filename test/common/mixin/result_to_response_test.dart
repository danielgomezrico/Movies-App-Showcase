// These tests are testing all cases for a throw
// ignore_for_file: only_throw_errors
// We use this class only on this test
// ignore_for_file: prefer-match-file-name

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/mixins/result_to_response.dart';

import '../../test_utils/factories.dart';

// We use this class only on this test
// ignore: prefer-match-file-name
class _MixinHolder with ResultToResponse {}

void main() {
  _MixinHolder subject() => _MixinHolder();

  group('responseToResult', () {
    group('with a success response', () {
      test('returns a success result', () async {
        final result = await subject().responseToResult(() {
          return Future.value(ResponseMother.success('any'));
        });

        expect(result.isSuccess, isTrue);
      });
    });

    group('with a failure response', () {
      test('returns a failure result', () async {
        final result = await subject().responseToResult(() {
          return Future.value(ResponseMother.failure<dynamic>());
        });

        expect(result.isFailure, isTrue);
      });
    });

    group('throwing a network error', () {
      for (final error in ApiErrorMother.networkErrors) {
        test('returns a failure result with a ${error.runtimeType}', () async {
          final result = await subject().responseToResult<dynamic>(() {
            throw error;
          });

          expect(
            result.error,
            'It looks like you do not have network connection.',
          );
        });
      }
    });

    group('throwing a network error', () {
      for (final error in ApiErrorMother.deserializationErrors) {
        test('returns a failure result with a ${error.runtimeType}', () async {
          final result = await subject().responseToResult<dynamic>(() {
            throw error;
          });

          expect(
            result.error,
            'Error with our services, try again later.',
          );
        });
      }
    });
  });
}
