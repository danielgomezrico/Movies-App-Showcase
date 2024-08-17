import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_view_model.dart';

mixin _ShowMovieSpy on MovieDetailViewModel {
  int showMovieCallCount = 0;

  @override
  Future<void> showMovie(Movie movie) async {
    showMovieCallCount++;
  }
}

class MovieDetailViewModelOnInitSpy extends MovieDetailViewModel
    with _ShowMovieSpy {
  MovieDetailViewModelOnInitSpy(
    super.moviesRepository,
    super.movieSummary,
    super.dateFormatter,
    super.saveFavoriteMovie,
    super.isMovieFavorite,
    super.removeFavoriteMovie,
    super.router,
  );
}
