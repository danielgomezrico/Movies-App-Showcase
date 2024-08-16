import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/database/storage.dart';
import 'package:movie_flutter/common/result.dart';

import '../../test_utils/database_utils.dart';
import '../../test_utils/mocks.dart';

void main() {
  final databaseInitializer = TestDatabaseInitializer();

  Future<void> setUpDatabase(List<Storage> storages) async {
    await Database.initialize(storages, initializer: databaseInitializer);
  }

  Future<void> tearDownDatabase() async {
    await databaseInitializer.tearDown();
  }

  group('.initialize', () {
    group('if one storage throws exception it must continue with others', () {
      final storage = MockStorage();
      final storage2 = MockStorage();
      final storage3 = MockStorage();

      setUpAll(() async {
        when(storage2.initialize()).thenThrow('BOOOM');

        await setUpDatabase([storage, storage2, storage3]);
      });

      tearDownAll(tearDownDatabase);

      test('initialize the storage', () {
        verify(storage.initialize());
      });

      test('initialize the storage 2', () {
        verify(storage2.initialize());
      });

      test('initialize the storage 3', () {
        verify(storage3.initialize());
      });
    });

    group('with multiple storages initialize them all', () {
      final storage = MockStorage();
      final storage2 = MockStorage();
      final storage3 = MockStorage();

      setUpAll(() async {
        await setUpDatabase([storage, storage2, storage3]);
      });

      tearDownAll(tearDownDatabase);

      test('initialize the storage', () {
        verify(storage.initialize());
      });

      test('initialize the storage 2', () {
        verify(storage2.initialize());
      });

      test('initialize the storage 3', () {
        verify(storage3.initialize());
      });
    });

    group('called multiple times', () {
      tearDownAll(tearDownDatabase);

      test('do not throw exception', () async {
        try {
          await setUpDatabase([MockStorage()]);
          await setUpDatabase([MockStorage()]);
        } catch (e) {
          fail('Should not throw exception');
        }
      });
    });
  });

  group('.storage', () {
    test('getting an existing type returns it', () async {
      await setUpDatabase([MockStorage()]);
      expect(Database.storage<MockStorage>(), isA<MockStorage>());
    });

    test('getting a weird type throws exception', () async {
      await setUpDatabase([MockStorage()]);
      expect(() => Database.storage<_DoNothingStorage>(), throwsException);
    });
  });
}

// We can add this on tests
// ignore: prefer-match-file-name
class _DoNothingStorage extends Storage {
  @override
  String get name => 'DO_NOTHING';

  @override
  // We need it empty to do nothing on tests
  // ignore: no-empty-block
  Future<void> initialize() async {}

  @override
  Future<EmptyResult> deleteAll() async => emptyOk;
}
