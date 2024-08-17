import 'package:movie_flutter/api/api.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/di/common_module.dart';
import 'package:movie_flutter/common/di/use_case_module.dart';
import 'package:movie_flutter/feature/movie_detail/movie_detail_view_model.dart';
import 'package:movie_flutter/widget/favorite_movies/favorite_movies_view_model.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_view_model.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item_view_model.dart';

abstract class ViewModelModule {
  static MovieShowcaseViewModel movieShowcaseViewModel() {
    return MovieShowcaseViewModel(
      Api.moviesRepository(),
    );
  }

  static MovieDetailViewModel movieDetailViewModel(MovieSummary movieSummary) {
    return MovieDetailViewModel(
      Api.moviesRepository(),
      movieSummary,
      CommonModule.dateFormatter(),
      UseCaseModule.queueFavoriteMovieUseCase(),
      UseCaseModule.isMovieFavoriteUseCase(),
      UseCaseModule.removeFavoriteMovieUseCase(),
      CommonModule.router(),
    );
  }

  static MovieSummaryItemViewModel moveSummaryItemViewModel(
    MovieSummary movieSummary,
  ) {
    return MovieSummaryItemViewModel(
      movieSummary,
      CommonModule.router(),
      CommonModule.eventBus(),
    );
  }

  static FavoriteMoviesViewModel favoriteMoviesViewModel() {
    return FavoriteMoviesViewModel(
      UseCaseModule.findFavoriteMoviesUseCase(),
      CommonModule.eventBus(),
    );
  }
}
