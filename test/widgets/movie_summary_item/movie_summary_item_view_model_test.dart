import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/router/site/movie_detail_site.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_item_view_model.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_status.dart';

import '../../test_utils/mocks.dart';

typedef _Status = MovieSummaryStatus;

void main() {
  final router = MockRouter();
  final eventBus = MockEventBus();

  MovieSummaryItemViewModel subject({MovieSummary? movieSummary}) {
    return MovieSummaryItemViewModel(
      movieSummary ?? MovieSummaryMother.build(),
      router,
      eventBus,
    );
  }

  group('constructor', () {
    test('', () {
      final movieSummary = MovieSummaryMother.build(
        title: 'my title',
        voteAverage: 5,
        imagePath: '/mypath',
      );

      final status = subject(movieSummary: movieSummary).status;

      expect(
        status,
        isA<_Status>()
            .having((s) => s.title, 'title', 'my title')
            .having((s) => s.voteAverage, 'voteAverage', '5.0')
            .having(
              (s) => s.imageUrl,
              'imageUrl',
              'https://image.tmdb.org/t/p/w500/mypath',
            ),
      );
    });
  });

  group('onTap', () {
    group('having a un favorite result from router', () {
      setUpAll(() async {
        when(router.pushTo(any)).thenFuture(MovieDetailSiteMother.result);
        await subject().onTap();
      });

      test('shows the detail', () {
        verify(
          router.pushTo(argThat(isA<MovieDetailSite>())),
        );
      });

      test('emits the change', () {
        verify(eventBus.fire<BusEvent>(
          argThat(isA<MovieRemovedFromFavoriteEvent>()),
        ));
      });
    });

    group('without any result from router', () {
      setUpAll(() async {
        when(router.pushTo(any)).thenFuture(null);
        await subject().onTap();
      });

      test('shows the detail', () {
        verify(
          router.pushTo(argThat(isA<MovieDetailSite>())),
        );
      });

      test('do not emits the change', () {
        verifyNever(eventBus.fire<BusEvent>(
          argThat(isA<MovieRemovedFromFavoriteEvent>()),
        ));
      });
    });
  });
}
