import 'package:built_value/built_value.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';

part 'movie_showcase_status.g.dart';

abstract class MovieShowcaseStatus
    implements Built<MovieShowcaseStatus, MovieShowcaseStatusBuilder> {
  MovieShowcaseStatus._();
  factory MovieShowcaseStatus(
          [void Function(MovieShowcaseStatusBuilder) updates]) =
      _$MovieShowcaseStatus;

  List<MovieSummary> get items;

  bool get isLoadingVisible;

  bool get isEmptyVisible;

  String? get errorMessage;

  MovieSort get sort;
}
