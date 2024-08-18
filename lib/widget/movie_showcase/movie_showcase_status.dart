import 'package:built_value/built_value.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';

part 'movie_showcase_status.g.dart';

abstract class MovieShowcaseStatus
    implements Built<MovieShowcaseStatus, MovieShowcaseStatusBuilder> {
  factory MovieShowcaseStatus(
          [void Function(MovieShowcaseStatusBuilder) updates]) =
      _$MovieShowcaseStatus;

  MovieShowcaseStatus._();

  List<MovieSummary> get items;

  bool get isLoadingVisible;

  bool get isEmptyVisible;

  String? get errorMessage;

  bool get showMoviesOnGrid;

  bool get isSettingsVisible;
}
