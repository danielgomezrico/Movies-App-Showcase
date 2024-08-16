import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';
import 'package:movie_flutter/common/view_model.dart';

import '../../common/log.dart';
import 'movie_detail_status.dart';

class MovieDetailViewModel extends ViewModel<MovieDetailStatus> {
  MovieDetailViewModel(
    this._moviesRepository,
    this._movieSummary,
    this._dateFormatter,
    this._saveFavoriteMovie,
    this._isMovieFavorite,
    this._removeFavoriteMovie,
  ) {
    var voteAverage = '(${_movieSummary.voteAverage} votes)';

    status = MovieDetailStatus(
      (b) {
        b
          ..isLoadingVisible = true
          ..isFavoriteVisible = false
          ..genres = []
          ..releaseDate = null
          ..overview = _movieSummary.overview
          ..title = _movieSummary.title
          ..imageUrl = _movieSummary.url
          ..voteAverage = voteAverage
          ..voteCount = _movieSummary.voteCount.toString()
          ..language = null;
      },
    );
  }

  final MoviesRepository _moviesRepository;
  final MovieSummary _movieSummary;
  final DateFormatter _dateFormatter;
  final SaveFavoriteMovieUseCase _saveFavoriteMovie;
  final IsMovieFavoriteUseCase _isMovieFavorite;
  final RemoveFavoriteMovieUseCase _removeFavoriteMovie;
  Movie? _movie;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..isFavoriteVisible = false,
    );

    await _moviesRepository.get(_movieSummary.movieId).match(
      onSuccess: (movie) {
        _movie = movie;
        _showMovie(movie);
      },
      onError: (error) {
        log.e(
          '[vm] Error getting movie: $error',
          error: error,
          stackTrace: StackTrace.current,
        );
        status = status.rebuild((b) => b..isLoadingVisible = false);
      },
    );
  }

  // TODO: Add tests
  void onSaveFavorite() async {
    var movie = _movie;
    if (movie == null) {
      log.w('[vm] Movie is null saving a favorite movie');
      return;
    }

    final bool isFavorite;
    if (status.isFavorite == true) {
      status = status.rebuild((b) => b..isFavorite = false);

      final result = await _removeFavoriteMovie(movie, _movieSummary);
      log.d('[vm] removing a favorite movie: $result');

      isFavorite = !result.isSuccess;
    } else {
      status = status.rebuild((b) => b..isFavorite = true);

      final result = await _saveFavoriteMovie(movie, _movieSummary);
      log.d('[vm] saving a favorite movie: $result');

      isFavorite = result.isSuccess;
    }

    status = status.rebuild((b) => b..isFavorite = isFavorite);
  }

  void _showMovie(Movie movie) async {
    final releaseDate = _releaseDate(movie);
    final language = _language(movie);
    final genres = movie.genres.map((g) => g.name).toList();
    bool isFavorite = await _isFavorite(movie);

    status = status.rebuild(
      (b) {
        return b
          ..isFavoriteVisible = true
          ..isFavorite = isFavorite
          ..isLoadingVisible = false
          ..genres = genres
          ..releaseDate = releaseDate
          ..language = language;
      },
    );
  }

  Future<bool> _isFavorite(Movie movie) async {
    bool isMovieFavorite = false;

    await _isMovieFavorite(movie).match(
      onSuccess: (isFavorite) => isMovieFavorite = isFavorite,
      onError: (error) => isMovieFavorite = false,
    );

    return isMovieFavorite;
  }

  String _releaseDate(Movie movie) {
    return movie.releaseDate != null
        ? _dateFormatter.formatDate(movie.releaseDate!)
        : 'Unknown';
  }

  String _language(Movie movie) {
    final String language;
    if (movie.languages.isEmpty) {
      language = 'Unknown';
    } else {
      language = movie.languages.map((l) => l.name).join(', ');
    }
    return language;
  }
}
