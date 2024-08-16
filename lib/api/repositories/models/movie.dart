import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value_flutter/hive_flutter.dart';

part 'movie.g.dart';

@HiveType(typeId: 0, adapterName: 'MovieAdapter')
abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  Movie._();

  static Serializer<Movie> get serializer => _$movieSerializer;

  @HiveField(0)
  int get id;

  @HiveField(1)
  @BuiltValueField(wireName: 'original_title')
  String get name;

  @HiveField(2)
  @BuiltValueField(wireName: 'poster_path')
  String get posterPath;

  String get url {
    // TODO(danielgomezrico): use different sizes for different devices
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  @HiveField(3)
  BuiltList<Genre> get genres;

  @HiveField(4)
  String get overview;

  @HiveField(5)
  @BuiltValueField(wireName: 'release_date')
  DateTime? get releaseDate;

  @HiveField(6)
  @BuiltValueField(wireName: 'spoken_languages')
  BuiltList<Language> get languages;

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Movie')..add('id', id)).toString();
  }
}

@HiveType(typeId: 1, adapterName: 'MovieGenreAdapter')
abstract class Genre implements Built<Genre, GenreBuilder> {
  factory Genre([void Function(GenreBuilder) updates]) = _$Genre;

  Genre._();

  static Serializer<Genre> get serializer => _$genreSerializer;

  @HiveField(0)
  String get name;
}

@HiveType(typeId: 2, adapterName: 'MovieLanguageAdapter')
abstract class Language implements Built<Language, LanguageBuilder> {
  factory Language([void Function(LanguageBuilder) updates]) = _$Language;

  Language._();

  static Serializer<Language> get serializer => _$languageSerializer;

  @HiveField(0)
  String get name;
}
