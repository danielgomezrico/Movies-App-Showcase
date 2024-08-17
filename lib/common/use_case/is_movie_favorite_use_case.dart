import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/result.dart';

class IsMovieFavoriteUseCase {
  const IsMovieFavoriteUseCase(this._favoriteMoviesStorage);

  final FavoriteMovieSummaryStorage _favoriteMoviesStorage;

  Future<Result<bool>> call(Movie movie) async {
    final value =
        await _favoriteMoviesStorage.get(movie.id).mapValue((movie) => true);

    var isFavorite = false;
    value.match(
      onSuccess: (s) => isFavorite = true,
      onError: (e) => isFavorite = false,
    );

    return Result.ok(isFavorite);
  }
}
