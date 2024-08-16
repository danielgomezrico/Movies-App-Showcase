import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/result.dart';

typedef FavoriteContent = (List<Movie>, List<MovieSummary>);

class FindFavoriteMoviesUseCase {
  const FindFavoriteMoviesUseCase();

  Future<Result<FavoriteContent>> call() {
    return Future.value(Result.ok(([], [])));
  }
}
