import 'package:movie_flutter/api/mixins/result_to_response.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/movies_remote_service.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/common/result.dart';

class MoviesRepository with ResultToResponse {
  const MoviesRepository(this._service, this._favoriteMovieStorage);

  final MoviesRemoteService _service;
  final FavoriteMovieStorage _favoriteMovieStorage;

  Future<PagedResult<List<MovieSummary>>> getMovies(
    int page,
    MovieSort sort,
  ) async {
    return responseToResult(
      () => _service.fetchMovies(page, sort),
    ).mapValue((value) {
      return PagedContent(
        payload: value.results.toList(),
        page: value.page,
        totalPages: value.totalPages,
        totalResults: value.totalResults,
      );
    });
  }

  Future<Result<Movie>> get(int movieId) async {
    final fetch = await responseToResult(() => _service.fetchMovie(movieId));

    if (fetch.isSuccess) {
      return fetch;
    } else {
      return _favoriteMovieStorage.get(movieId);
    }
  }
}
