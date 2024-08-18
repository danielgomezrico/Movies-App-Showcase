import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:movie_flutter/api/repositories/models/movie_category.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/log.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_status.dart';

const _initialPageIndex = 1;

class MovieShowcaseViewModel extends ViewModel<MovieShowcaseStatus> {
  MovieShowcaseViewModel(this._moviesRepository) {
    status = MovieShowcaseStatus(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..items = []
        ..isSettingsVisible = false
        ..showMoviesOnGrid = false
        ..movieCategory = MovieCategory.popular,
    );
  }

  final MoviesRepository _moviesRepository;

  @visibleForTesting
  int page = _initialPageIndex;
  @visibleForTesting
  MovieSort sort = MovieSort.titleAsc;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null,
    );

    await showNextMovies(sort);
  }

  Future<void> onBottomReached() async {
    await showNextMovies(sort);
  }

  Future<void> onCategoryChanged(MovieCategory movieCategory) async {
    page = _initialPageIndex;

    status = status.rebuild(
      (b) => b
        ..items = []
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null
        ..movieCategory = movieCategory,
    );

    await showNextMovies(sort);
  }

  Future<void> onSortChanged(MovieSort movieSort) async {
    page = _initialPageIndex;
    sort = movieSort;

    status = status.rebuild(
      (b) => b
        ..items = []
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..errorMessage = null,
    );

    await showNextMovies(movieSort);
  }

  void onSettingsTap() {
    status = status.rebuild(
      (b) => b..isSettingsVisible = !status.isSettingsVisible,
    );
  }

  void onShowMoviesOnGridTap() {
    status = status.rebuild(
      (b) => b..showMoviesOnGrid = !status.showMoviesOnGrid,
    );
  }

  @visibleForTesting
  Future<void> showNextMovies(MovieSort sort) async {
    await _moviesRepository.getMovies(page, sort, status.movieCategory).match(
      onSuccess: (data) {
        page++;

        final allItems = List.of(status.items)..addAll(data.payload);

        status = status.rebuild(
          (b) => b
            ..items = allItems
            ..isEmptyVisible = allItems.isEmpty
            ..isLoadingVisible = false,
        );
      },
      onError: (error) {
        log.e(
          '[vm] Error fetching movies',
          error: error,
          stackTrace: StackTrace.current,
        );

        status = status.rebuild(
          (b) => b
            ..errorMessage = error.toString()
            ..isLoadingVisible = false,
        );
      },
    );
  }
}
