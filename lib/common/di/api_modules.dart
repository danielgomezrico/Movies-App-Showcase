import 'package:movie_flutter/api/movies_repository.dart';

abstract class ApiModules {
  static MoviesRepository moviesRepository() {
    return const MoviesRepository();
  }
}