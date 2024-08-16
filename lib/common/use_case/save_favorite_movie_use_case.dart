import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/result.dart';

class SaveFavoriteMovieUseCase {
  const SaveFavoriteMovieUseCase(
    this._favoriteMovieStorage,
    this._favoriteMovieSummaryStorage,
  );

  final FavoriteMovieStorage _favoriteMovieStorage;
  final FavoriteMovieSummaryStorage _favoriteMovieSummaryStorage;

  Future<EmptyResult> call(Movie movie, MovieSummary summary) async {
    return _favoriteMovieStorage
        .append(movie)
        .mapValue((_) => _favoriteMovieSummaryStorage.append(summary))
        .mapValue((_) => const EmptyContent());
  }
}
