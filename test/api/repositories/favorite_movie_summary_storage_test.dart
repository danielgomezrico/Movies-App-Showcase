import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/result.dart';

import '../../test_utils/database_utils.dart';
import '../../test_utils/factories.dart';

typedef _Model = MovieSummary;

void main() async {
  FavoriteMovieSummaryStorage subject() {
    return Database.storage<FavoriteMovieSummaryStorage>();
  }

  FavoriteMovieSummaryStorage storage() => FavoriteMovieSummaryStorage();

  test('append data then it succeed', () async {
    await runClosingDb([storage()], () async {
      final result = await subject().append(MovieSummaryMother.base);

      expect(result,
          isA<EmptyResult>().having((r) => r.isSuccess, 'success', isTrue));
    });
  });

  test('saving multiple data returns the latest one', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieSummaryMother.build(movieId: 1));
      await storage.append(MovieSummaryMother.build(movieId: 2));

      final result = await storage.getAll();

      expect(
        result.value,
        isA<List<_Model>>()
            .having((l) => l.length, 'length', 2)
            .having((l) => l[0].movieId, 'id', 1)
            .having((l) => l[1].movieId, 'id', 2),
      );
    });
  });

  test('saving multiple data returns the one with id', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieSummaryMother.build(movieId: 1));
      await storage.append(MovieSummaryMother.build(movieId: 2));

      final result = await storage.get(1);

      expect(
        result.value,
        isA<_Model>().having((m) => m.movieId, 'id', 1),
      );
    });
  });

  test('getting an item that does not exist it returns ', () async {
    await runClosingDb([storage()], () async {
      final storage = subject();

      await storage.append(MovieSummaryMother.build(movieId: 1));
      await storage.append(MovieSummaryMother.build(movieId: 2));

      final result = await storage.get(3);

      expect(result.isFailure, isTrue);
    });
  });

  group('when the database is closed and reopened', () {
    test('serialize it fine', () async {
      await runClosingDb(
        [storage()],
        () {
          var storage = subject();

          storage.append(MovieSummaryMother.build(movieId: 1));
          return storage.append(MovieSummaryMother.build(movieId: 2));
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
            .having((l) => l[0].movieId, 'id', 1)
            .having((l) => l[1].movieId, 'id', 2),
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
        final result = await storage().append(MovieSummaryMother.base);
        expect(result.isFailure, isTrue);
      });
    });
  });

  test('when deleting data is success', () async {
    await runClosingDb([storage()], () async {
      final result = await subject().delete(MovieSummaryMother.base);
      expect(result.isSuccess, isTrue);
    });
  });

  test('deleting data it returns empty', () async {
    await runClosingDb([storage()], () async {
      await subject().append(MovieSummaryMother.base);
      await subject().delete(MovieSummaryMother.base);

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
