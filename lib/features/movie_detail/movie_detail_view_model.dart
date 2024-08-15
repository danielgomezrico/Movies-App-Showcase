import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/api/movies_repository.dart';
import 'package:movie_flutter/common/result.dart';
import 'package:movie_flutter/common/view_model.dart';

import 'movie_detail_status.dart';

class MovieDetailViewModel extends ViewModel<MovieDetailStatus> {
  MovieDetailViewModel(this._moviesRepository, this._movieSummary) {
    var voteAverage = '(${_movieSummary.voteAverage} votes)';

    status = MovieDetailStatus(
      (b) {
        b
          ..isLoadingVisible = true
          ..genres = []
          ..releaseDate = null
          ..overview = null
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

  Future<void> onInit() async {
    status = status.rebuild((b) => b..isLoadingVisible = true);

    await _moviesRepository.movie(_movieSummary.movieId).match(
      onSuccess: (movie) {
        final releaseDate = movie.releaseDate != null
            ? movie.releaseDate!.toLocal().toString().split(' ')[0]
            : 'Unknown';

        final String language;
        if (movie.languages.isEmpty) {
          language = 'Unknown';
        } else {
          language = movie.languages.join(', ');
        }

        status = status.rebuild(
          (b) {
            return b
              ..isLoadingVisible = false
              ..genres = movie.genres
              ..overview = movie.overview
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
