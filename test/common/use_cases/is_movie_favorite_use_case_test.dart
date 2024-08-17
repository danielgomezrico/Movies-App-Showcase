import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';

import '../../test_utils/mocks.dart';

void main() {
  final favoriteMoviesStorage = MockFavoriteMovieSummaryStorage();

  IsMovieFavoriteUseCase subject() {
    return IsMovieFavoriteUseCase(favoriteMoviesStorage);
  }

  group('.call', () {
    group('having the movie already stored', () {
      test('returns true', () async {
        when(favoriteMoviesStorage.get(any)).thenOk(MovieSummaryMother.base);

        final result = await subject().call(MovieMother.base);

        expect(result.value, isTrue);
      });
    });

    group('without the image stored or got an error', () {
      test('returns false', () async {
        when(favoriteMoviesStorage.get(any)).thenError();

        final result = await subject().call(MovieMother.base);

        expect(result.value, isFalse);
      });
    });
  });
}
