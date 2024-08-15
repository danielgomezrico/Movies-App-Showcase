import 'package:built_value/built_value.dart';

part 'movie_detail_status.g.dart';

abstract class MovieDetailStatus
    implements Built<MovieDetailStatus, MovieDetailStatusBuilder> {
  factory MovieDetailStatus([void Function(MovieDetailStatusBuilder) updates]) =
      _$MovieDetailStatus;

  MovieDetailStatus._();

  bool get isLoadingVisible;

  String get title;

  String get imageUrl;

  String? get overview;

  List<String> get genres;

  String? get releaseDate;

  String? get language;

  String? get voteAverage;

  String? get voteCount;
}
