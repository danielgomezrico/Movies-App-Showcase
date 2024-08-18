// This is the group of spies
// ignore_for_file: prefer-match-file-name

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/widget/favorite_movies/favorite_movies_status.dart';
import 'package:movie_flutter/widget/favorite_movies/favorite_movies_view_model.dart';

import '../../test_utils/mocks.dart';
import 'spies.dart';

typedef _Status = FavoriteMoviesStatus;

void main() {
  final findFavoriteMovies = MockFindFavoriteMovieSummariesUseCase();
  final eventBus = MockEventBus();

  FavoriteMoviesViewModel subject() {
    return FavoriteMoviesViewModel(findFavoriteMovies, eventBus);
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
    FavoriteMoviesViewModelOnInitSpy subject() {
      return FavoriteMoviesViewModelOnInitSpy(findFavoriteMovies, eventBus);
    }

    late FavoriteMoviesViewModelOnInitSpy viewModel;

    setUpAll(() async {
      viewModel = subject();
      await viewModel.onInit();
    });

    test('shows the next movie', () {
      expect(viewModel.showMoviesCallCount, 1);
    });

    test('listen events', () {
      expect(viewModel.listenEventsCallCount, 1);
    });
  });

  group('.showMovies', () {
    group('after getting favorite movies', () {
      test('shows them', () async {
        when(findFavoriteMovies.call()).thenOk(MovieSummaryMother.list);

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showMovies();

        expect(
          status,
          emitsInOrder([
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
                .having((s) => s.errorMessage, 'errorMessage', isNull),
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isFalse)
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
                .having((s) => s.items, 'items', MovieSummaryMother.list),
          ]),
        );
      });
    });

    group('after getting empty movies', () {
      test('updates the UI', () async {
        when(findFavoriteMovies.call()).thenOk([]);

        final viewModel = subject();

        final status = viewModel.statusChanges();

        await viewModel.showMovies();

        expect(
          status,
          emitsInOrder([
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse),
            isA<_Status>()
                .having((s) => s.isLoadingVisible, 'isLoadingVisible', isFalse)
                .having((s) => s.items, 'items', isEmpty)
                .having((s) => s.isEmptyVisible, 'isEmptyVisible', isTrue),
          ]),
        );
      });

      group('after getting an error fetching favorites', () {
        test('shows the error', () async {
          when(findFavoriteMovies.call()).thenError();

          final viewModel = subject();

          final status = viewModel.statusChanges();

          await viewModel.showMovies();

          expect(
            status,
            emitsInOrder([
              isA<_Status>()
                  .having((s) => s.isLoadingVisible, 'isLoadingVisible', isTrue)
                  .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse)
                  .having((s) => s.errorMessage, 'error', isNull),
              isA<_Status>()
                  .having(
                    (s) => s.isLoadingVisible,
                    'isLoadingVisible',
                    isFalse,
                  )
                  .having((s) => s.errorMessage, 'error', 'error')
                  .having((s) => s.isEmptyVisible, 'isEmptyVisible', isFalse),
            ]),
          );
        });
      });
    });
  });

  group('.listenEvents', () {
    group('with a favorite removed event', () {
      test('removes the favorite item from the items', () async {
        when(eventBus.events<BusEvent>())
            .thenStream(BusEventMother.movieRemovedFromFavoriteEvent);

        final viewModel = subject();
        viewModel.status = viewModel.status.rebuild((b) => b
          ..items = [
            MovieSummaryMother.build(movieId: 3),
            MovieSummaryMother.build(movieId: 1),
            MovieSummaryMother.build(movieId: 2),
          ]);
        final status = viewModel.statusChanges();

        viewModel.listenEvents();
        await pumpEventQueue();

        expect(
            status,
            emits(
              isA<_Status>()
                  .having((s) => s.items, 'items', hasLength(2))
                  .having((s) => s.items.first.movieId, 'first', 3)
                  .having((s) => s.items.last.movieId, 'second', 2)
                  .having((s) => s.isEmptyVisible, 'empty', isFalse),
            ));
      });

      test('removing the last items it show the empty page', () async {
        when(eventBus.events<BusEvent>())
            .thenStream(BusEventMother.movieRemovedFromFavoriteEvent);

        final viewModel = subject();
        viewModel.status = viewModel.status
            .rebuild((b) => b..items = [MovieSummaryMother.any]);
        final status = viewModel.statusChanges();

        viewModel.listenEvents();
        await pumpEventQueue();

        expect(
            status,
            emits(
              isA<_Status>()
                  .having((s) => s.items, 'items', hasLength(0))
                  .having((s) => s.isEmptyVisible, 'empty', isTrue),
            ));
      });
    });

    group('with another event', () {
      test('do not emit anything', () async {
        when(eventBus.events<BusEvent>()).thenStream(const _BusEventStub());

        final viewModel = subject();
        final statusController = viewModel.statusChangesController();

        viewModel.listenEvents();

        await pumpEventQueue();
        statusController.close();

        expect(statusController.stream, neverEmits(anything));
      });
    });
  });
}

class _BusEventStub extends BusEvent {
  const _BusEventStub();
}
