import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';

part 'movie_summary_response.g.dart';

abstract class MovieSummaryResponse
    implements Built<MovieSummaryResponse, MovieSummaryResponseBuilder> {
  factory MovieSummaryResponse(
          [void Function(MovieSummaryResponseBuilder) updates]) =
      _$MovieSummaryResponse;

  MovieSummaryResponse._();

  static Serializer<MovieSummaryResponse> get serializer =>
      _$movieSummaryResponseSerializer;

  BuiltList<MovieSummary> get results;

  int get page;

  @BuiltValueField(wireName: 'total_pages')
  int get totalPages;

  @BuiltValueField(wireName: 'total_results')
  int get totalResults;
}
