import 'package:built_value/built_value.dart';

part 'movie_summary_status.g.dart';

abstract class MovieSummaryStatus
    implements Built<MovieSummaryStatus, MovieSummaryStatusBuilder> {
  MovieSummaryStatus._();
  factory MovieSummaryStatus(
          [void Function(MovieSummaryStatusBuilder) updates]) =
      _$MovieSummaryStatus;

  String get title;

  String get voteAverage;

  String get imageUrl;
}
