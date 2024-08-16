import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/result.dart';

class RemoveFavoriteMovieUseCase {
  const RemoveFavoriteMovieUseCase();

  Future<EmptyResult> call(Movie movie, MovieSummary summary) async {
    await Future.delayed(const Duration(seconds: 1));

    return emptyOk;
  }
}