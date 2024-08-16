import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/log.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_status.dart';

const defaultPage = 1;

class MovieShowcaseViewModel extends ViewModel<MovieShowcaseStatus> {
  MovieShowcaseViewModel(this._moviesRepository) {
    status = MovieShowcaseStatus(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..sort = MovieSort.titleAsc
        ..items = [],
    );
  }

  final MoviesRepository _moviesRepository;
  int _page = defaultPage;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null,
    );

    await showNextMovies(status.sort);
  }

  Future<void> onBottomReached() async {
    await showNextMovies(status.sort);
  }

  Future<void> onSortChanged(MovieSort sort) async {
    _page = defaultPage;

    status = status.rebuild(
      (b) => b
        ..sort = sort
        ..items = []
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null,
    );

    await showNextMovies(sort);
  }

  @visibleForTesting
  Future<void> showNextMovies(MovieSort sort) async {
    await _moviesRepository.getMovies(_page, sort).match(
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
