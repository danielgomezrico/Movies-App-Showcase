import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/use_case/find_favorite_movie_summaries_use_case.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/favorite_movies/favorite_movies_status.dart';

class FavoriteMoviesViewModel extends ViewModel<FavoriteMoviesStatus> {
  FavoriteMoviesViewModel(this._findFavoriteMovies, this._eventBus) {
    status = FavoriteMoviesStatus(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..items = [],
    );
  }

  final FindFavoriteMovieSummariesUseCase _findFavoriteMovies;
  final EventBus _eventBus;
  StreamSubscription<dynamic>? _eventsSubscription;

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  Future<void> onInit() async {
    await showMovies();
    listenEvents();
  }

  @visibleForTesting
  Future<void> showMovies() async {
    status = status.rebuild((b) => b
      ..isLoadingVisible = true
      ..isEmptyVisible = false);

    await _findFavoriteMovies().match(
      onSuccess: (movieSummaries) {
        status = status.rebuild(
          (b) => b
            ..isLoadingVisible = false
            ..isEmptyVisible = movieSummaries.isEmpty
            ..items = movieSummaries,
        );
      },
      onError: (error) {
        status = status.rebuild(
          (b) => b
            ..isLoadingVisible = false
            ..isEmptyVisible = true
            ..errorMessage = error.toString(),
        );
      },
    );
  }

  @visibleForTesting
  void listenEvents() {
    _eventsSubscription = _eventBus.events<BusEvent>().listen((event) {
      if (event is MovieRemovedFromFavoriteEvent) {
        final items = List.of(status.items);
        items.removeWhere((element) => element.movieId == event.movieId);

        status = status.rebuild(
          (b) => b
            ..items = items
            ..isEmptyVisible = items.isEmpty,
        );
      }
    });
  }
}
