import 'package:built_collection/built_collection.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/result.dart';

abstract class MovieMother {
  static get base {
    return Movie(
      (b) => b
        ..name = 'The Dark Knight'
        ..posterPath = '/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg'
        ..genres = ListBuilder(['Action', 'Crime', 'Drama', 'Thriller'])
        ..overview =
            'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.'
        ..releaseDate = null
        ..languages = ListBuilder(['English', 'Mandarin']),
    );
  }

  static Movie build({
    String name = 'The Dark Knight',
    String posterUrl =
        'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
    List<String> genres = const ['Action', 'Crime', 'Drama', 'Thriller'],
    String overview =
        'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',
    DateTime? releaseDate,
    List<String> languages = const ['English', 'Mandarin'],
  }) {
    return Movie(
      (b) => b
        ..name = name
        ..posterPath = posterUrl
        ..genres = ListBuilder(genres)
        ..overview = overview
        ..releaseDate = releaseDate
        ..languages = ListBuilder(languages),
    );
  }
}

abstract class MovieSummaryMother {
  static get base {
    return MovieSummary(
      (b) => b
        ..movieId = 1
        ..imagePath = '/a.jpg'
        ..title = 'The Dark Knight'
        ..overview = 'overview'
        ..voteAverage = 3.4
        ..voteCount = 24169,
    );
  }

  static MovieSummary build({
    int movieId = 1,
    String imagePath = '/a.jpg',
    String title = 'The Dark Knight',
    String overview = 'overview',
    double voteAverage = 8.4,
    int voteCount = 24169,
  }) {
    return MovieSummary(
      (b) => b
        ..movieId = movieId
        ..imagePath = imagePath
        ..title = title
        ..overview = overview
        ..voteAverage = voteAverage
        ..voteCount = voteCount,
    );
  }
}

abstract class ResultMother {
  static PagedResult<T> okPagedResult<T>({
    required T payload,
    int page = 1,
    int totalPages = 1,
    int totalResults = 1,
  }) {
    return Result.ok(
      PagedContent(
        page: page,
        totalPages: totalPages,
        totalResults: totalResults,
        payload: payload,
      ),
    );
  }
}
