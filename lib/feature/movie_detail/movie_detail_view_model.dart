import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/router/router.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';
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
    this._router,
  ) {
    final voteAverage = '(${_movieSummary.voteAverage} votes)';

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
  final Router _router;

  @visibleForTesting
  Movie? movie;

  Future<void> onInit() async {
    status = status.rebuild(
      (b) => b
        ..isLoadingVisible = true
        ..isFavoriteVisible = false,
    );

    await _moviesRepository.get(_movieSummary.movieId).match(
      onSuccess: (movie) {
        this.movie = movie;
        showMovie(movie);
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

  Future<void> onSaveFavorite() async {
    final movie = this.movie;
    if (movie == null) {
      log.w('[vm] Movie is null saving a favorite movie');
      return;
    }

    if (status.isFavorite ?? false) {
      status = status.rebuild((b) => b..isFavorite = false);

      final result = await _removeFavoriteMovie(movie, _movieSummary);
      if (!result.isSuccess) {
        status = status.rebuild((b) => b..isFavorite = true);
        // TODO(danielgomezrico): show snackbar with the error
      }
    } else {
      status = status.rebuild((b) => b..isFavorite = true);

      final result = await _saveFavoriteMovie(movie, _movieSummary);
      if (!result.isSuccess) {
        status = status.rebuild((b) => b..isFavorite = false);
        // TODO(danielgomezrico): show snackbar with the error
      }
    }
  }

  @visibleForTesting
  Future<void> showMovie(Movie movie) async {
    final releaseDate = _releaseDate(movie);
    final language = _language(movie);
    final genres = movie.genres.map((g) => g.name).toList();
    final isFavorite = await _isFavorite(movie);

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
    var isMovieFavorite = false;

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

  void onBackTap() {
    if (status.isFavorite == false) {
      _router.pop(const MovieRemovedFromFavorite());
    } else {
      _router.pop();
    }
  }
}
