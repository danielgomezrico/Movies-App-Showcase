import 'package:hive_built_value_flutter/hive_flutter.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/common/log.dart';

import 'storage.dart';

const _tag = '[db]';

abstract class Database {
  Database._();

  static List<Storage> _storages = [];

  static Future<void> initialize(
    List<Storage> storages, {
    DatabaseInitializer initializer = const FlutterDatabaseInitializer(),
  }) async {
    _storages = storages;

    log.d('$_tag Initializing database');
    await initializer.initialize();

    try {
      _registerOnce(MovieAdapter());
      _registerOnce(MovieLanguageAdapter());
      _registerOnce(MovieGenreAdapter());
      _registerOnce(MovieSummaryAdapter());
    } catch (e, stack) {
      log.e(
        '$_tag Failed registering adapters',
        error: e,
        stackTrace: stack,
      );
    }

    for (final storage in storages) {
      try {
        await storage.initialize();
      } catch (e, stack) {
        log.e(
          '$_tag Failed to initialize ${storage.name}',
          error: e,
          stackTrace: stack,
        );
      }
    }
  }

  static T storage<T extends Storage>() {
    final storage = _storages.firstWhere(
      (s) => s is T,
      orElse: () => throw Exception('Storage $T not found'),
    );

    return storage as T;
  }

  static void _registerOnce<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }
}

abstract class DatabaseInitializer {
  const DatabaseInitializer();

  Future<void> initialize();
}

class FlutterDatabaseInitializer extends DatabaseInitializer {
  const FlutterDatabaseInitializer();

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
  }
}
