import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_view_model.dart';

mixin _ShowNextMoviesSpy on MovieShowcaseViewModel {
  int showNextMoviesCount = 0;

  @override
  Future<void> showNextMovies(MovieSort sort) async {
    showNextMoviesCount++;
  }
}

class MovieShowcaseViewModelShowNextMoviesSpy extends MovieShowcaseViewModel
    with _ShowNextMoviesSpy {
  MovieShowcaseViewModelShowNextMoviesSpy(
    super.moviesRepository,
  );
}

class MovieShowcaseViewModelOnInitSpy extends MovieShowcaseViewModel
    with _ShowNextMoviesSpy {
  MovieShowcaseViewModelOnInitSpy(
    super.moviesRepository,
  );
}

class MovieShowcaseViewModelOnSortChanges extends MovieShowcaseViewModel
    with _ShowNextMoviesSpy {
  MovieShowcaseViewModelOnSortChanges(
    super.moviesRepository,
  );
}
