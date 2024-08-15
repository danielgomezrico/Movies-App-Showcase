import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/router/site.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_page.dart';

class MovieDetailSite extends Site {
  const MovieDetailSite(this._movieSummary);

  final MovieSummary _movieSummary;

  @override
  String get name => 'MOVIE_DETAIL';

  @override
  Widget get widget => MovieDetailPage(movieSummary: _movieSummary);
}
