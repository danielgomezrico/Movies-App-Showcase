import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/router/sites/movie_detail_site.dart';
import 'package:movie_flutter/widgets/movie_summary_item/movie_summary_item_view_model.dart';
import 'package:movie_flutter/widgets/movie_summary_item/movie_summary_status.dart';

import '../../test_utils/mocks.dart';

typedef _Status = MovieSummaryStatus;

void main() {
  final router = MockRouter();

  MovieSummaryItemViewModel subject({MovieSummary? movieSummary}) {
    return MovieSummaryItemViewModel(
      movieSummary ?? MovieSummaryMother.build(),
      router,
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
    test('shows the detail', () {
      when(router.pushTo(any)).thenFuture(null);

      subject().onTap();

      verify(
        router.pushTo(argThat(isA<MovieDetailSite>())),
      );
    });
  });
}
