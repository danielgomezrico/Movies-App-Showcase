import 'package:movie_flutter/api/movies_repository.dart';

abstract class ApiModule {
  static MoviesRepository moviesRepository() {
    return const MoviesRepository();
  }
}