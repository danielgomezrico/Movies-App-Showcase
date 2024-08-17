import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/use_case/find_favorite_movie_summaries_use_case.dart';

import '../../test_utils/mocks.dart';

void main() {
  final storage = MockFavoriteMovieSummaryStorage();

  FindFavoriteMovieSummariesUseCase subject() {
    return FindFavoriteMovieSummariesUseCase(storage);
  }

  group('.call', () {
    test('should return all favorite movie summaries', () async {
      when(storage.getAll()).thenOk(MovieSummaryMother.list);

      final result = await subject().call();

      expect(
        result.value,
        isA<List<MovieSummary>>()
            .having((v) => v.length, 'length', 2)
            .having((v) => v[0].movieId, 'id', 1)
            .having((v) => v[1].movieId, 'id', 2),
      );
    });

    group('with an empty storage', () {
      test('returns an empty array', () async {
        when(storage.getAll()).thenOk([]);

        final result = await subject().call();

        expect(
          result.value,
          isA<List<MovieSummary>>().having((v) => v, 'length', isEmpty),
        );
      });
    });

    group('with an error getting storage', () {
      test('returns the error', () async {
        when(storage.getAll()).thenError();
        final result = await subject().call();
        expect(result.isFailure, isTrue);
      });
    });
  });
}
