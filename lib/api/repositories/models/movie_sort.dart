import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'movie_sort.g.dart';

class MovieSort extends EnumClass {
  const MovieSort._(super.name);

  static BuiltSet<MovieSort> get values => _$movieSortValues;
  static MovieSort valueOf(String name) => _$movieSortValueOf(name);

  static Serializer<MovieSort> get serializer => _$movieSortSerializer;


  @BuiltValueEnumConst(wireName: 'original_title.asc')
  static const MovieSort titleAsc = _$titleAsc;

  @BuiltValueEnumConst(wireName: 'original_title.desc')
  static const MovieSort titleDesc = _$titleDesc;

  @BuiltValueEnumConst(wireName: 'primary_release_date.asc')
  static const MovieSort releaseDateAsc = _$releaseDateAsc;

  @BuiltValueEnumConst(wireName: 'primary_release_date.desc')
  static const MovieSort releaseDateDesc = _$releaseDateDesc;

  String wiredValue() {
    switch(this) {
      case MovieSort.titleAsc:
        return 'original_title.asc';
      case MovieSort.titleDesc:
        return 'original_title.desc';
      case MovieSort.releaseDateAsc:
        return 'primary_release_date.asc';
      case MovieSort.releaseDateDesc:
        return 'primary_release_date.desc';
    }

    throw Exception('Unknown value: $this');
  }

  @override
  String toString() {
    return wiredValue();
  }
}
