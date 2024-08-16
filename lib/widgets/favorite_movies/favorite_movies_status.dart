import 'package:built_value/built_value.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'favorite_movies_status.g.dart';

abstract class FavoriteMoviesStatus
    implements Built<FavoriteMoviesStatus, FavoriteMoviesStatusBuilder> {
  FavoriteMoviesStatus._();
  factory FavoriteMoviesStatus(
          [void Function(FavoriteMoviesStatusBuilder) updates]) =
      _$FavoriteMoviesStatus;

  List<MovieSummary> get items;

  bool get isLoadingVisible;

  bool get isEmptyVisible;

  String? get errorMessage;
}
