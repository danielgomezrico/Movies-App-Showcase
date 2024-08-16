import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value_flutter/hive_flutter.dart';

part 'movie_summary.g.dart';

@HiveType(typeId: 4, adapterName: 'MovieSummaryAdapter')
abstract class MovieSummary
    implements Built<MovieSummary, MovieSummaryBuilder> {
  factory MovieSummary([void Function(MovieSummaryBuilder) updates]) =
      _$MovieSummary;

  MovieSummary._();

  static Serializer<MovieSummary> get serializer => _$movieSummarySerializer;

  @HiveField(0)
  @BuiltValueField(wireName: 'id')
  int get movieId;

  @HiveField(1)
  String get title;

  @HiveField(2)
  String get overview;

  @HiveField(3)
  @BuiltValueField(wireName: 'vote_average')
  double get voteAverage;

  @HiveField(4)
  @BuiltValueField(wireName: 'vote_count')
  int get voteCount;

  @HiveField(5)
  @BuiltValueField(wireName: 'poster_path')
  String? get imagePath;

  String? get url {
    if (imagePath == null) return null;

    // TODO(danielgomezrico): use different sizes for different devices
    return 'https://image.tmdb.org/t/p/w500$imagePath';
  }
}
