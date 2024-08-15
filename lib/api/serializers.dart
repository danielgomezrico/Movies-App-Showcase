import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
// Imported manually because: https://github.com/google/built_value.dart/issues/1159
// ignore: implementation_imports
import 'package:built_value/src/json_object_serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary_response.dart';

part 'serializers.g.dart';

//add all of the built value types that require serialization
@SerializersFor([
  MovieSummaryResponse,
  Movie,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(JsonObjectSerializer())
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
