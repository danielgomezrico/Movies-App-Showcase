import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/result.dart';

class FindFavoriteMovieSummariesUseCase {
  const FindFavoriteMovieSummariesUseCase(this._storage);

  final FavoriteMovieSummaryStorage _storage;

  Future<Result<List<MovieSummary>>> call() {
    return _storage.getAll();
  }
}
