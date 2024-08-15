import 'package:built_value/built_value.dart';
import 'package:movie_flutter/api/models.dart';

part 'movie_showcase_status.g.dart';

abstract class MovieShowcaseStatus
    implements Built<MovieShowcaseStatus, MovieShowcaseStatusBuilder> {
  MovieShowcaseStatus._();
  factory MovieShowcaseStatus(
          [void Function(MovieShowcaseStatusBuilder) updates]) =
      _$MovieShowcaseStatus;

  List<MovieSummary> get items;

  bool get isLoadingVisible;

  String? get errorMessage;
}
