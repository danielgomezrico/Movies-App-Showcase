import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';

import '../../test_utils/mocks.dart';

void main() {
  final favoriteMovieStorage = MockFavoriteMovieStorage();
  final favoriteMovieSummaryStorage = MockFavoriteMovieSummaryStorage();

  SaveFavoriteMovieUseCase subject() {
    return SaveFavoriteMovieUseCase(
      favoriteMovieStorage,
      favoriteMovieSummaryStorage,
    );
  }

  group('.call', () {
    group('with all saved', () {
      test('returns success', () async {
        when(favoriteMovieStorage.append(any)).thenOk();
        when(favoriteMovieSummaryStorage.append(any)).thenOk();

        final result =
            await subject().call(MovieMother.any, MovieSummaryMother.any);

        expect(result.isSuccess, isTrue);
      });
    });

    group('with an error deleting from storage', () {
      test('returns success', () async {
        when(favoriteMovieStorage.append(any)).thenError();
        when(favoriteMovieSummaryStorage.append(any)).thenOk();

        final result =
            await subject().call(MovieMother.any, MovieSummaryMother.any);

        expect(result.isFailure, isTrue);
      });
    });
  });
}
