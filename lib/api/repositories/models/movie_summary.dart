import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'movie_summary.g.dart';

abstract class MovieSummary
    implements Built<MovieSummary, MovieSummaryBuilder> {
  MovieSummary._();
  factory MovieSummary([void Function(MovieSummaryBuilder) updates]) =
      _$MovieSummary;

  static Serializer<MovieSummary> get serializer => _$movieSummarySerializer;

  @BuiltValueField(wireName: 'id')
  int get movieId;

  String get title;

  String get overview;

  @BuiltValueField(wireName: 'vote_average')
  double get voteAverage;

  @BuiltValueField(wireName: 'vote_count')
  int get voteCount;

  @BuiltValueField(wireName: 'poster_path')
  String get imagePath;

  String get url {
    // TODO: use different sizes for different devices
    return 'https://image.tmdb.org/t/p/w500$imagePath';
  }
}
