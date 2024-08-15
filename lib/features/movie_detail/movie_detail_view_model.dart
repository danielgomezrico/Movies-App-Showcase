import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';

import 'movie_detail_status.dart';

class MovieDetailViewModel extends ViewModel<MovieDetailStatus> {
  MovieDetailViewModel(
    this._moviesRepository,
    this._movieSummary,
    this._dateFormatter,
  ) {
    var voteAverage = '(${_movieSummary.voteAverage} votes)';

    status = MovieDetailStatus(
      (b) {
        b
          ..isLoadingVisible = true
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

  Future<void> onInit() async {
    status = status.rebuild((b) => b..isLoadingVisible = true);

    await _moviesRepository.get(_movieSummary.movieId).match(
      onSuccess: (movie) {
        final releaseDate = movie.releaseDate != null
            ? _dateFormatter.formatDate(movie.releaseDate!)
            : 'Unknown';

        final String language;
        if (movie.languages.isEmpty) {
          language = 'Unknown';
        } else {
          language = movie.languages.join(', ');
        }

        final genres = movie.genres.map((g) => g.name).toList();

        status = status.rebuild(
          (b) {
            return b
              ..isLoadingVisible = false
              ..genres = genres
              ..releaseDate = releaseDate
              ..language = language;
          },
        );
      },
      onError: (error) {
        status = status.rebuild((b) => b..isLoadingVisible = false);
      },
    );
  }
}
