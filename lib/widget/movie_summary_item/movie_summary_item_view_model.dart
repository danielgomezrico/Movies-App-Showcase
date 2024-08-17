import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/router/router.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widget/movie_summary_item/movie_summary_status.dart';

class MovieSummaryItemViewModel extends ViewModel<MovieSummaryStatus> {
  MovieSummaryItemViewModel(this._movieSummary, this._router, this._eventBus) {
    status = MovieSummaryStatus(
      (b) => b
        ..title = _movieSummary.title
        ..voteAverage = _movieSummary.voteAverage.toString()
        ..imageUrl = _movieSummary.url,
    );
  }

  final MovieSummary _movieSummary;
  final Router _router;
  final EventBus _eventBus;

  Future<void> onTap() async {
    final siteResult = await _router.pushTo(MovieDetailSite(_movieSummary));

    if (siteResult is MovieRemovedFromFavorite) {
      final event = MovieRemovedFromFavoriteEvent(_movieSummary.movieId);
      _eventBus.fire(event);
    }
  }
}
