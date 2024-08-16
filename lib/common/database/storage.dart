import 'package:movie_flutter/common/result.dart';

abstract class Storage {
  String get name;

  Future<void> initialize();

  Future<EmptyResult> deleteAll();
}
