import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/log.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_status.dart';

class MovieShowcaseViewModel extends ViewModel<MovieShowcaseStatus> {
  MovieShowcaseViewModel(this._moviesRepository) {
    status = MovieShowcaseStatus(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..items = [],
    );
  }

  final MoviesRepository _moviesRepository;
  int _page = 1;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null,
    );

    await showNextMovies();
  }

  Future<void> onBottomReached() async {
    await showNextMovies();
  }

  @visibleForTesting
  Future<void> showNextMovies() async {
    await _moviesRepository.getMovies(_page).match(
      onSuccess: (data) {
        _page++;

        final allItems = List.of(status.items)..addAll(data.payload);

        status = status.rebuild(
          (b) => b
            ..items = allItems
            ..isEmptyVisible = allItems.isEmpty
            ..isLoadingVisible = false,
        );
      },
      onError: (error) {
        log.e('[vm] Error fetching movies: $error');

        status = status.rebuild(
          (b) => b
            ..errorMessage = error
            ..isLoadingVisible = false,
        );
      },
    );
  }
}
