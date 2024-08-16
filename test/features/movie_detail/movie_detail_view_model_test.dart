import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_status.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_view_model.dart';

import '../../test_utils/mocks.dart';
import 'spies.dart';

typedef _Status = MovieDetailStatus;

void main() {
  final moviesRepository = MockMoviesRepository();

  final dateFormatter = MockDateFormatter();
  final saveFavoriteMovie = MockSaveFavoriteMovieUseCase();
  final isMovieFavorite = MockIsMovieFavoriteUseCase();
  final removeFavoriteMovie = MockRemoveFavoriteMovieUseCase();

  MovieDetailViewModel subject({MovieSummary? movieSummary}) {
    final summary = movieSummary ?? MovieSummaryMother.base;

    return MovieDetailViewModel(
      moviesRepository,
      summary,
      dateFormatter,
      saveFavoriteMovie,
      isMovieFavorite,
      removeFavoriteMovie,
    );
  }

  group('constructor', () {
    test('emits the constructor', () {
      final summary = MovieSummaryMother.build(
        title: 'title',
        overview: 'overview',
        imagePath: '/path',
        voteAverage: 1,
        voteCount: 1,
      );
      final viewModel = subject(movieSummary: summary);

      expect(
        viewModel.status,
        isA<_Status>()
            .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
            .having((s) => s.isFavoriteVisible, 'isFavoriteVisible', isFalse)
            .having((s) => s.genres, 'genres', isEmpty)
            .having((s) => s.releaseDate, 'releaseDate', isNull)
            .having((s) => s.overview, 'overview', 'overview')
            .having((s) => s.title, 'title', 'title')
            .having((s) => s.imageUrl, 'imageUrl',
                'https://image.tmdb.org/t/p/w500/path')
            .having((s) => s.voteAverage, 'voteAverage', '(1.0 votes)')
            .having((s) => s.voteCount, 'voteCount', '1')
            .having((s) => s.language, 'language', isNull),
      );
    });
  });

  group('.onInit', () {
    MovieDetailViewModelOnInitSpy subject() {
      return MovieDetailViewModelOnInitSpy(
        moviesRepository,
        MovieSummaryMother.base,
        dateFormatter,
        saveFavoriteMovie,
        isMovieFavorite,
        removeFavoriteMovie,
      );
    }

    group('with a movie', () {
      late Stream<_Status> status;
      late MovieDetailViewModelOnInitSpy viewModel;

      setUpAll(() async {
        when(moviesRepository.get(any)).thenOk(MovieMother.base);

        viewModel = subject();
        status = viewModel.statusChanges();

        await viewModel.onInit();
      });

      test('show the movie', () {
        expect(viewModel.showMovieCallCount, 1);
      });

      test('updates the internal status', () {
        expect(viewModel.movie, MovieMother.base);
      });

      test('emits the status', () {
        expect(
          status,
          emits(
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
                .having(
                    (s) => s.isFavoriteVisible, 'isFavoriteVisible', isFalse),
          ),
        );
      });
    });

    group('with an error getting the movie', () {
      late Stream<_Status> status;
      late MovieDetailViewModelOnInitSpy viewModel;

      setUpAll(() async {
        when(moviesRepository.get(any)).thenError();

        viewModel = subject();
        status = viewModel.statusChanges();

        await viewModel.onInit();
      });

      test('do not show the movie', () {
        expect(viewModel.showMovieCallCount, 0);
      });

      test('emits the status', () {
        expect(
          status,
          emitsInOrder([
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
                .having(
                    (s) => s.isFavoriteVisible, 'isFavoriteVisible', isFalse),
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isFalse),
          ]),
        );
      });
    });
  });

  group('.showMovie', () {
    group('with a favorite movie', () {
      test('emits it', () {
        when(isMovieFavorite(any)).thenOk(true);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(MovieMother.base);

        expect(
          status,
          emits(
            isA<_Status>()
                .having((s) => s.isFavoriteVisible, 'isFavoriteVisible', isTrue)
                .having((s) => s.isFavorite, 'isFavorite', isTrue),
          ),
        );
      });
    });

    group('with a non favorite movie', () {
      test('emits it', () {
        when(isMovieFavorite(any)).thenOk(false);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(MovieMother.base);

        expect(
          status,
          emits(
            isA<_Status>()
                .having((s) => s.isFavoriteVisible, 'isFavoriteVisible', isTrue)
                .having((s) => s.isFavorite, 'isFavorite', isFalse),
          ),
        );
      });
    });

    group('with a movie with empty genres', () {
      test('emits it', () {
        final movie = MovieMother.build(genres: []);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(movie);

        expect(
          status,
          emits(isA<_Status>().having((s) => s.genres, 'genres', isEmpty)),
        );
      });
    });

    group('with a movie with empty languages', () {
      test('emits it', () {
        final movie = MovieMother.build(languages: []);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(movie);

        expect(
          status,
          emits(
            isA<_Status>().having((s) => s.language, 'language', 'Unknown'),
          ),
        );
      });
    });

    group('with a movie with no release date', () {
      test('emits it', () {
        final movie = MovieMother.build(genres: []);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(movie);

        expect(
          status,
          emits(isA<_Status>().having((s) => s.releaseDate, 'date', 'Unknown')),
        );
      });
    });

    group('with all the data', () {
      test('emits it', () {
        final movie = MovieMother.build(
          languages: ['language', 'language2'],
          genres: ['genre', 'genre2'],
          releaseDate: DateTime(2021, 1, 1),
        );
        when(dateFormatter.formatDate(any)).thenReturn('Jan 1, 2021');
        when(isMovieFavorite(any)).thenOk(true);

        final viewModel = subject();
        final status = viewModel.statusChanges();

        viewModel.showMovie(movie);

        expect(
          status,
          emits(
            isA<_Status>()
                .having((s) => s.isFavoriteVisible, 'isFavoriteVisible', isTrue)
                .having((s) => s.isFavorite, 'isFavorite', isTrue)
                .having((s) => s.genres, 'genres', ['genre', 'genre2'])
                .having((s) => s.releaseDate, 'releaseDate', 'Jan 1, 2021')
                .having((s) => s.language, 'language', 'language, language2'),
          ),
        );
      });
    });
  });

  group('.onSaveFavorite', () {
    group('having a favorite movie', () {
      setUpAll(() async {
        final viewModel = subject();
        viewModel.movie = MovieMother.base;

        viewModel.onSaveFavorite();
      });

      test('remove movie from favorites', () {});
    });
  });
}
