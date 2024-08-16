import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/result.dart';

import '../../test_utils/database_utils.dart';
import '../../test_utils/factories.dart';

typedef _Model = Movie;

void main() async {
  FavoriteMovieStorage subject() => Database.storage<FavoriteMovieStorage>();
  FavoriteMovieStorage storage() => FavoriteMovieStorage();

  test('append data then it succeed', () async {
    await runClosingDb([storage()], () async {
      final result = await subject().append(MovieMother.base);

      expect(result,
          isA<EmptyResult>().having((r) => r.isSuccess, 'success', isTrue));
    });
  });

  test('saving multiple data returns the latest one', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieMother.build(id: 1));
      await storage.append(MovieMother.build(id: 2));

      final result = await storage.getAll();

      expect(
        result.value,
        isA<List<_Model>>()
            .having((l) => l.length, 'length', 2)
            .having((l) => l[0].id, 'id', 1)
            .having((l) => l[1].id, 'id', 2),
      );
    });
  });

  test('saving multiple data returns the one with id', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieMother.build(id: 1));
      await storage.append(MovieMother.build(id: 2));

      final result = await storage.get(1);

      expect(
        result.value,
        isA<_Model>().having((m) => m.id, 'id', 1),
      );
    });
  });

  test('getting an item that does not exist', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieMother.build(id: 1));
      await storage.append(MovieMother.build(id: 2));

      final result = await storage.get(3);

      expect(result.isFailure, isTrue);
    });
  });

  group('when the database is closed and reopened', () {
    test('serialize it fine', () async {
      await runClosingDb(
        [storage()],
        () {
          final storage = subject();

          storage.append(MovieMother.build(id: 1));
          return storage.append(MovieMother.build(id: 2));
        },
        dbTag: 'movie',
        deleteOnTearDown: false,
      );

      final result = await runClosingDb(
        [storage()],
        () => subject().getAll(),
        dbTag: 'movie',
      );

      expect(
        result.value,
        isA<List<_Model>>()
            .having((l) => l.length, 'length', 2)
            .having((l) => l[0].id, 'id', 1)
            .having((l) => l[1].id, 'id', 2),
      );
    });
  });

  test('without saved data returns empty', () async {
    await runClosingDb([storage()], () async {
      final result = await subject().getAll();

      expect(
        result,
        isA<Result<List<_Model>>>().having((r) => r.value, 'value', isEmpty),
      );
    });
  });

  group('without initializing the database', () {
    test('get returns a failure', () async {
      await runClosingDb([storage()], () async {
        final result = await storage().getAll();
        expect(result.isFailure, isTrue);
      });
    });

    test('append returns a failure', () async {
      await runClosingDb([storage()], () async {
        final result = await storage().append(MovieMother.base);
        expect(result.isFailure, isTrue);
      });
    });
  });

  test('when deleting data is success', () async {
    await runClosingDb([storage()], () async {
      final result = await subject().delete(MovieMother.base);
      expect(result.isSuccess, isTrue);
    });
  });

  test('deleting data it returns empty', () async {
    await runClosingDb([storage()], () async {
      await subject().append(MovieMother.base);
      await subject().delete(MovieMother.base);

      final result = await subject().getAll();

      expect(
        result,
        isA<Result<List<_Model>>>().having(
          (r) => r.value,
          'value',
          isEmpty,
        ),
      );
    });
  });
}
