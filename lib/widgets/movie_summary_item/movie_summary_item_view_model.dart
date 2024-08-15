import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/router/router.dart';
import 'package:movie_flutter/common/router/sites/movie_detail_site.dart';
import 'package:movie_flutter/common/view_model.dart';
import 'package:movie_flutter/widgets/movie_summary_item/movie_summary_status.dart';

class MovieSummaryItemViewModel extends ViewModel<MovieSummaryStatus> {
  MovieSummaryItemViewModel(this._movieSummary, this._router) {
    status = MovieSummaryStatus(
      (b) => b
        ..title = _movieSummary.title
        ..voteAverage = _movieSummary.voteAverage.toString()
        ..imageUrl = _movieSummary.url,
    );
  }

  final MovieSummary _movieSummary;
  final Router _router;

  void onTap() {
    _router.pushTo(MovieDetailSite(_movieSummary));
  }
}
