import 'package:movie_flutter/api/movies_repository.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_status.dart';

class MovieShowcaseViewModel extends ViewModel<MovieShowcaseStatus> {
  MovieShowcaseViewModel(this._moviesRepository) {
    status = MovieShowcaseStatus(
      (b) => b
        ..isLoadingVisible = true
        ..items = [],
    );
  }

  final MoviesRepository _moviesRepository;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..errorMessage = null,
    );

    await _moviesRepository.movies().match(
      onSuccess: (movies) {
        status = status.rebuild(
          (b) => b
            ..items = movies
            ..isLoadingVisible = false,
        );
      },
      onError: (error) {
        print('[vm] Error fetching decks: $error');

        status = status.rebuild(
          (b) => b
            ..errorMessage = 'Error'
            ..isLoadingVisible = false,
        );
      },
    );
  }
}
