// We include multiple extensions on the same file
// ignore_for_file: prefer-match-file-name

import 'dart:developer' show log;
import 'dart:io';

import 'package:hive_built_value_flutter/hive_flutter.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/database/storage.dart';
import 'package:uuid/uuid.dart';

Future<T> runClosingDb<T>(
  List<Storage> storages,
  Future<T> Function() doIt, {
  String? dbTag,
  bool deleteOnTearDown = true,
}) async {
  final databaseInitializer = TestDatabaseInitializer(dbTag);
  await Database.initialize(storages, initializer: databaseInitializer);

  final result = await doIt();

  if (deleteOnTearDown) {
    await databaseInitializer.tearDown();
  } else {
    await databaseInitializer.close();
  }

  return result;
}

String uuid() {
  return const Uuid().v4();
}

class TestDatabaseInitializer extends DatabaseInitializer {
  TestDatabaseInitializer([this.dbTag]);

  final String? dbTag;
  String? _dbFile;

  @override
  Future<void> initialize() async {
    try {
      final path = Directory.current.path;

      final dbFile = '$path/test/db/${dbTag ?? uuid()}';
      _dbFile = dbFile;

      Hive.init(dbFile);
    } catch (e, stack) {
      log('Error initializing database: $e\n$stack');
    }
  }

  Future<void> tearDown() async {
    try {
      await Hive.deleteFromDisk();
    } catch (e, stack) {
      log('Error deleting database: $e\n$stack');
    }

    try {
      final file = _dbFile;
      if (file == null) return;

      final dbDirectory = Directory(file);
      if (dbDirectory.existsSync()) {
        await dbDirectory.delete(recursive: true);
      }
    } catch (e, stack) {
      log('Error deleting database: $e\n$stack');
    }
  }

  Future<void> close() {
    try {
      return Hive.close();
    } catch (e, stack) {
      log('Error closing database: $e\n$stack');

      return Future.value();
    }
  }
}
