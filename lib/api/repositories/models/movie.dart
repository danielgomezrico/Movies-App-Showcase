import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  Movie._();
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  static Serializer<Movie> get serializer => _$movieSerializer;

  @BuiltValueField(wireName: 'original_title')
  String get name;

  @BuiltValueField(wireName: 'poster_path')
  String get posterPath;

  String get url {
    // TODO: use different sizes for different devices
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  BuiltList<Genre> get genres;

  String get overview;

  @BuiltValueField(wireName: 'release_date')
  DateTime? get releaseDate;

  @BuiltValueField(wireName: 'spoken_languages')
  BuiltList<Language> get languages;
}

abstract class Genre implements Built<Genre, GenreBuilder> {
  Genre._();
  factory Genre([void Function(GenreBuilder) updates]) = _$Genre;

  static Serializer<Genre> get serializer => _$genreSerializer;

  String get name;
}

abstract class Language implements Built<Language, LanguageBuilder> {
  Language._();
  factory Language([void Function(LanguageBuilder) updates]) = _$Language;

  static Serializer<Language> get serializer => _$languageSerializer;

  String get name;
}
