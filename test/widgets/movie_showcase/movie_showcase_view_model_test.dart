import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_status.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase_view_model.dart';

import '../../test_utils/mocks.dart';
import 'spies.dart';

typedef _Status = MovieShowcaseStatus;

void main() {
  final moviesRepository = MockMoviesRepository();

  MovieShowcaseViewModel subject() {
    return MovieShowcaseViewModel(moviesRepository);
  }

  group('constructor', () {
    test('initializes status', () {
      final viewModel = subject();

      expect(
        viewModel.status,
        isA<_Status>()
            .having((s) => s.items, 'items', isEmpty)
            .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
            .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
            .having((s) => s.errorMessage, 'errorMessage', null)
            .having((s) => s.items, 'items', isEmpty),
      );
    });
  });

  group('onInit', () {
    MovieShowcaseViewModelOnInitSpy subject() {
      return MovieShowcaseViewModelOnInitSpy(moviesRepository);
    }

    late MovieShowcaseViewModelOnInitSpy viewModel;
    late Stream<_Status> status;

    setUpAll(() async {
      viewModel = subject();
      status = viewModel.statusChanges();

      await viewModel.onInit();
    });

    test('shows loading status', () {
      expect(
        status,
        emits(
          isA<_Status>()
              .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
              .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ),
      );
    });

    test('shows the next movie', () {
      expect(viewModel.showNextMoviesCount, 1);
    });
  });

  group('.onBottomReached', () {
    MovieShowcaseViewModelShowNextMoviesSpy subject() {
      return MovieShowcaseViewModelShowNextMoviesSpy(moviesRepository);
    }

    test('after it reaches the bottom it shows next movies', () async {
      final viewModel = subject();
      await viewModel.onBottomReached();
      expect(viewModel.showNextMoviesCount, 1);
    });
  });

  group('.showNextMovies', () {
    group('having multiple pages', () {
      test('it joins them all', () async {
        when(moviesRepository.getMovies(any, any, any)).thenFutureInOrder([
          ResultMother.okPagedResult(
            payload: [MovieSummaryMother.base],
          ),
          ResultMother.okPagedResult(
            payload: [MovieSummaryMother.base, MovieSummaryMother.base],
          ),
        ]);

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showNextMovies(MovieSort.titleAsc);
        await viewModel.showNextMovies(MovieSort.titleAsc);

        expect(
          status,
          emitsInOrder([
            isA<_Status>().having((s) => s.items, 'items', hasLength(1)),
            isA<_Status>().having((s) => s.items, 'items', hasLength(3)),
          ]),
        );
      });
    });

    group('after getting empty movies', () {
      test('updates the UI', () async {
        when(moviesRepository.getMovies(any, any, any)).thenOk(const []);

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showNextMovies(MovieSort.titleAsc);

        expect(
          status,
          emits(
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isFalse)
                .having((s) => s.items, 'items', isEmpty)
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isTrue),
          ),
        );
      });
    });

    group('after getting all items', () {
      test('shows the items', () async {
        when(moviesRepository.getMovies(any, any, any)).thenOk([
          MovieSummaryMother.base,
          MovieSummaryMother.base,
        ]);

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showNextMovies(MovieSort.titleAsc);

        expect(
          status,
          emits(
            isA<_Status>()
                .having(
                  (s) => s.isLoadingVisible,
                  'isLoadingVisible',
                  isFalse,
                )
                .having((s) => s.items, 'items', hasLength(2))
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse),
          ),
        );
      });
    });

    group('after getting an error', () {
      test('shows the error', () async {
        when(moviesRepository.getMovies(any, any, any)).thenError();

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showNextMovies(MovieSort.titleAsc);

        expect(
          status,
          emits(
            isA<_Status>()
                .having(
                  (s) => s.isLoadingVisible,
                  'isLoadingVisible',
                  isFalse,
                )
                .having((s) => s.errorMessage, 'error', 'error')
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse),
          ),
        );
      });
    });

    group('after getting an error getting movies', () {
      test('emits the status', () async {
        when(moviesRepository.getMovies(any, any, any)).thenError();

        final viewModel = subject();
        final status = viewModel.statusChanges();

        await viewModel.showNextMovies(MovieSort.titleAsc);

        expect(
          status,
          emits(isA<_Status>()
              .having((s) => s.isLoadingVisible, 'isLoadingVisible', isFalse)
              .having((s) => s.errorMessage, 'errorMessage', 'error')
              .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)),
        );
      });
    });
  });

  group('.onSortChanged', () {
    MovieShowcaseViewModelOnSortChanges subject() {
      return MovieShowcaseViewModelOnSortChanges(moviesRepository);
    }

    late Stream<_Status> status;
    late MovieShowcaseViewModelOnSortChanges viewModel;

    setUpAll(() async {
      viewModel = subject();
      status = viewModel.statusChanges();

      await viewModel.onSortChanged(MovieSort.titleAsc);
    });

    test('shown next movies', () {
      expect(viewModel.showNextMoviesCount, 1);
    });

    test('updates the current sorting', () {
      expect(viewModel.sort, MovieSort.titleAsc);
    });

    test('reset the current page', () {
      expect(viewModel.page, 1);
    });

    test('updates the status', () {
      expect(
        status,
        emits(
          isA<_Status>()
              .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
              .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.items, 'items', isEmpty),
        ),
      );
    });
  });
}
