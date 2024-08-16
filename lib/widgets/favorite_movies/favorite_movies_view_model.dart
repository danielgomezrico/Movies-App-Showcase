import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/use_case/find_favorite_movies_use_case.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/favorite_movies/favorite_movies_status.dart';

class FavoriteMoviesViewModel extends ViewModel<FavoriteMoviesStatus> {
  FavoriteMoviesViewModel(this._findFavoriteMovies) {
    status = FavoriteMoviesStatus(
      (b) => b
        ..isLoadingVisible = true
        ..isEmptyVisible = false
        ..items = [],
    );
  }

  final FindFavoriteMoviesUseCase _findFavoriteMovies;

  void onInit() async {
    status = status.rebuild((b) => b
      ..isLoadingVisible = true
      ..isEmptyVisible = false);

    await _findFavoriteMovies().match(
      onSuccess: (favoriteContent) {
        final movieSummaries = favoriteContent.$2;

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
}
