import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/router/site.dart';
import 'package:movie_flutter/feature/movie_detail/movie_detail_page.dart';

class MovieDetailSite extends Site<MovieRemovedFromFavorite> {
  const MovieDetailSite(this._movieSummary);

  final MovieSummary _movieSummary;

  @override
  String get name => 'MOVIE_DETAIL';

  @override
  Widget get widget => MovieDetailPage(movieSummary: _movieSummary);
}

class MovieRemovedFromFavorite extends SiteResult {
  const MovieRemovedFromFavorite();
}
