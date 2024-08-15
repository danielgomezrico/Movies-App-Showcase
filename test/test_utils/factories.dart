import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/result.dart';

abstract class MovieMother {
  static const base = Movie(
    name: 'The Dark Knight',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
    genres: ['Action', 'Crime', 'Drama', 'Thriller'],
    overview:
        'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',
    releaseDate: null,
    languages: ['English', 'Mandarin'],
    voteAverage: 8.4,
  );

  static Movie build({
    String name = 'The Dark Knight',
    String posterUrl =
        'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
    List<String> genres = const ['Action', 'Crime', 'Drama', 'Thriller'],
    String overview =
        'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',
    DateTime? releaseDate,
    List<String> languages = const ['English', 'Mandarin'],
    double voteAverage = 8.4,
  }) {
    return Movie(
      name: name,
      posterUrl: posterUrl,
      genres: genres,
      overview: overview,
      releaseDate: releaseDate,
      languages: languages,
      voteAverage: voteAverage,
    );
  }
}

abstract class MovieSummaryMother {
  static const base = MovieSummary(
    url: 'https://image.tmdb.org/t/p/w500/a.jpg',
    title: 'The Dark Knight',
    voteAverage: 3.4,
    voteCount: 24169,
  );

  static MovieSummary build({
    String url = 'https://image.tmdb.org/t/p/w500/a.jpg',
    String title = 'The Dark Knight',
    double voteAverage = 8.4,
    int voteCount = 24169,
  }) {
    return MovieSummary(
      url: url,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
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
