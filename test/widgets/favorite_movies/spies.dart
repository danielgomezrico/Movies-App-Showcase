// We group multiple spies in this file
// ignore_for_file: prefer-match-file-name

import 'package:movie_flutter/widget/favorite_movies/favorite_movies_view_model.dart';

mixin ShowMovies on FavoriteMoviesViewModel {
  int showMoviesCallCount = 0;

  @override
  Future<void> showMovies() async {
    showMoviesCallCount++;
  }
}

mixin ListenEvents on FavoriteMoviesViewModel {
  int listenEventsCallCount = 0;

  @override
  void listenEvents() {
    listenEventsCallCount++;
  }
}

class FavoriteMoviesViewModelOnInitSpy extends FavoriteMoviesViewModel
    with ShowMovies, ListenEvents {
  FavoriteMoviesViewModelOnInitSpy(
    super.findFavoriteMovies,
    super.eventBus,
  );
}
