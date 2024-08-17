import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';

import '../../test_utils/mocks.dart';

void main() {
  final favoriteMovieStorage = MockFavoriteMovieStorage();
  final favoriteMovieSummaryStorage = MockFavoriteMovieSummaryStorage();

  RemoveFavoriteMovieUseCase subject() {
    return RemoveFavoriteMovieUseCase(
      favoriteMovieStorage,
      favoriteMovieSummaryStorage,
    );
  }

  group('.call', () {
    group('with all deleted', () {
      test('returns success', () async {
        when(favoriteMovieStorage.delete(any)).thenOk();
        when(favoriteMovieSummaryStorage.delete(any)).thenOk();

        final result =
            await subject().call(MovieMother.base, MovieSummaryMother.base);

        expect(result.isSuccess, isTrue);
      });
    });

    group('with an error deleting from storage', () {
      test('returns success', () async {
        when(favoriteMovieStorage.delete(any)).thenError();
        when(favoriteMovieSummaryStorage.delete(any)).thenOk();

        final result =
            await subject().call(MovieMother.base, MovieSummaryMother.base);

        expect(result.isFailure, isTrue);
      });
    });
  });
}
