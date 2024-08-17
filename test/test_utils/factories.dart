// All factories live here
// ignore_for_file: prefer-match-file-name

import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/router/site/movie_detail_site.dart';

abstract class MovieMother {
  static Movie get base {
    return Movie(
      (b) => b
        ..id = 1
        ..name = 'The Dark Knight'
        ..posterPath = '/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg'
        ..genres = ListBuilder(['Action', 'Crime', 'Drama', 'Thriller']
            .map((g) => Genre((b) => b..name = g)))
        ..overview =
            'Batman raises the stakes in his war on crime. With the help of Lt.'
        ..popularity = 2.0
        ..releaseDate = null
        ..languages = ListBuilder(
          ['English', 'Mandarin'].map((l) => Language((b) => b..name = l)),
        ),
    );
  }

  static Movie build({
    int id = 1,
    String name = 'The Dark Knight',
    String posterUrl =
        'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
    List<String> genres = const ['Action', 'Crime', 'Drama', 'Thriller'],
    String overview =
        'Batman raises the stakes in his war on crime. With the help of Lt.',
    DateTime? releaseDate,
    double popularity = 2.0,
    List<String> languages = const ['English', 'Mandarin'],
  }) {
    return Movie(
      (b) => b
        ..id = id
        ..name = name
        ..posterPath = posterUrl
        ..genres = ListBuilder(genres.map((g) => Genre((b) => b..name = g)))
        ..overview = overview
        ..popularity = popularity
        ..releaseDate = releaseDate
        ..languages = ListBuilder(
          languages.map((l) => Language((b) => b..name = l)),
        ),
    );
  }
}

abstract class MovieSummaryMother {
  static MovieSummary get base {
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

  static List<MovieSummary> get list {
    return [
      build(movieId: 1),
      build(movieId: 2),
    ];
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

  static Result<T> ok<T>(T payload) {
    return Result.ok(payload);
  }
}

abstract class ResponseMother {
  static Response<T> success<T>(
    T body, {
    int code = 200,
    Map<String, String> headers = const {},
  }) {
    return Response(
      http.Response(body.toString(), code, headers: headers),
      body,
    );
  }

  static Response<T> failure<T>({
    String message = 'any',
    T? body,
    Object? error,
    Map<String, String> headers = const {},
    int statusCode = 400,
  }) {
    return Response(
      http.Response(message, statusCode, headers: headers),
      body,
      error: error,
    );
  }
}

abstract class ApiErrorMother {
  static List<Object> get errors {
    return [
      ...networkErrors,
      ...deserializationErrors,
    ];
  }

  static List<Object> get networkErrors {
    return [
      const SocketException('any'),
      const HandshakeException('any'),
      http.ClientException('any'),
    ];
  }

  static List<Object> get deserializationErrors {
    return [
      DeserializationError(null, FullType.object, TypeError()),
      const FormatException(),
    ];
  }
}

abstract class MovieDetailSiteMother {
  static const result = MovieRemovedFromFavorite();
}

abstract class BusEventMother {
  static MovieRemovedFromFavoriteEvent get movieRemovedFromFavoriteEvent {
    return const MovieRemovedFromFavoriteEvent(1);
  }
}
