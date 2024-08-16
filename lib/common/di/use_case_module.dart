import 'package:movie_flutter/common/use_case/find_favorite_movies_use_case.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';

abstract class UseCaseModule {
  static SaveFavoriteMovieUseCase queueFavoriteMovieUseCase() {
    return const SaveFavoriteMovieUseCase();
  }

  static IsMovieFavoriteUseCase isMovieFavoriteUseCase() {
    return const  IsMovieFavoriteUseCase();
  }

  static RemoveFavoriteMovieUseCase removeFavoriteMovieUseCase() {
    return const RemoveFavoriteMovieUseCase();
  }

  static FindFavoriteMoviesUseCase findFavoriteMoviesUseCase() {
    return const FindFavoriteMoviesUseCase();
  }
}
