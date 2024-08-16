import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_view_model.dart';

mixin ShowNextMovies on MovieShowcaseViewModel {
  int showNextMoviesCount = 0;

  @override
  Future<void> showNextMovies(MovieSort sort) async {
    showNextMoviesCount++;
  }
}

class MovieShowcaseViewModelShowNextMoviesSpy extends MovieShowcaseViewModel
    with ShowNextMovies {
  MovieShowcaseViewModelShowNextMoviesSpy(
    super.moviesRepository,
  );
}

class MovieShowcaseViewModelOnInitSpy extends MovieShowcaseViewModel
    with ShowNextMovies {
  MovieShowcaseViewModelOnInitSpy(
    super.moviesRepository,
  );
}

class MovieShowcaseViewModelOnSortChanges extends MovieShowcaseViewModel
    with ShowNextMovies {
  MovieShowcaseViewModelOnSortChanges(
    super.moviesRepository,
  );
}
