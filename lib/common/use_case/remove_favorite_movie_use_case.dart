import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/common/result.dart';

import '../../api/repositories/storages/favorite_movie_summary_storage.dart';

class RemoveFavoriteMovieUseCase {
  const RemoveFavoriteMovieUseCase(
    this._favoriteMovieStorage,
    this._favoriteMovieSummaryStorage,
  );

  final FavoriteMovieStorage _favoriteMovieStorage;
  final FavoriteMovieSummaryStorage _favoriteMovieSummaryStorage;

  Future<EmptyResult> call(Movie movie, MovieSummary summary) {
    return _favoriteMovieStorage
        .delete(movie)
        .mapValue((_) => _favoriteMovieSummaryStorage.delete(summary))
        .mapValue((_) => const EmptyContent());
  }
}
