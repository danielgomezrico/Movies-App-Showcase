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
  int _page = 1;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..errorMessage = null,
    );

    await _showNextMovies();
  }

  Future<void> onBottomReached() async {
    await _showNextMovies();
  }

  Future<void> _showNextMovies() async {
    await _moviesRepository.movies(_page).match(
      onSuccess: (data) {
        _page++;

        final allItems = List.of(status.items)..addAll(data.payload);

        status = status.rebuild(
          (b) => b
            ..items = allItems
            ..isLoadingVisible = false,
        );
      },
      onError: (error) {
        print('[vm] Error fetching movies: $error');

        status = status.rebuild(
          (b) => b
            ..errorMessage = 'Error'
            ..isLoadingVisible = false,
        );
      },
    );
  }
}
