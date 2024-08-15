import 'package:movie_flutter/api/mixins/result_to_response.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/movies_remote_service.dart';
import 'package:movie_flutter/common/result.dart';

class MoviesRepository with ResultToResponse {
  const MoviesRepository(this._service);

  final MoviesRemoteService _service;

  Future<PagedResult<List<MovieSummary>>> getMovies(int currentPage) async {
    return responseToResult(() => _service.fetchMovies(currentPage))
        .mapValue((value) {
      return PagedContent(
        payload: value.results.toList(),
        page: value.page,
        totalPages: value.totalPages,
        totalResults: value.totalResults,
      );
    });
  }

  Future<Result<Movie>> get(int movieId) async {
    return responseToResult(() => _service.fetchMovie(movieId));
  }
}
