import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/result.dart';

class IsMovieFavoriteUseCase {
  const IsMovieFavoriteUseCase(this._favoriteMoviesRepository);

  final FavoriteMovieSummaryStorage _favoriteMoviesRepository;

  Future<Result<bool>> call(Movie movie) {
    return _favoriteMoviesRepository
        .get(movie.id)
        .mapValue((movie) => true)
        .mapError((error) => false);
  }
}
