import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/common/result.dart';

class IsMovieFavoriteUseCase {
  const IsMovieFavoriteUseCase();

  Future<Result<bool>> call(Movie movie) async {
    return Result.ok(true);
  }
}