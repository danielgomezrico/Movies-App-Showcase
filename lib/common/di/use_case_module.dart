import 'package:movie_flutter/common/di/common_module.dart';
import 'package:movie_flutter/common/use_case/find_favorite_movie_summaries_use_case.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';

abstract class UseCaseModule {
  static SaveFavoriteMovieUseCase queueFavoriteMovieUseCase() {
    return SaveFavoriteMovieUseCase(
      CommonModule.favoriteMovieStorage(),
      CommonModule.favoriteMovieSummaryStorage(),
    );
  }

  static IsMovieFavoriteUseCase isMovieFavoriteUseCase() {
    return IsMovieFavoriteUseCase(
      CommonModule.favoriteMovieSummaryStorage(),
    );
  }

  static RemoveFavoriteMovieUseCase removeFavoriteMovieUseCase() {
    return RemoveFavoriteMovieUseCase(
      CommonModule.favoriteMovieStorage(),
      CommonModule.favoriteMovieSummaryStorage(),
    );
  }

  static FindFavoriteMovieSummariesUseCase findFavoriteMoviesUseCase() {
    return FindFavoriteMovieSummariesUseCase(
      CommonModule.favoriteMovieSummaryStorage(),
    );
  }
}
