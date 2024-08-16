import 'package:built_value/built_value.dart';

part 'movie_summary_status.g.dart';

abstract class MovieSummaryStatus
    implements Built<MovieSummaryStatus, MovieSummaryStatusBuilder> {
  factory MovieSummaryStatus(
          [void Function(MovieSummaryStatusBuilder) updates]) =
      _$MovieSummaryStatus;

  MovieSummaryStatus._();

  String get title;

  String get voteAverage;

  String? get imageUrl;
}
