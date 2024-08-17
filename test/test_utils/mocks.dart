// This is the mock setup and its not required
// ignore_for_file: prefer-match-file-name
// ignore_for_file: prefer-correct-test-file-name

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/database/storage.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/router/router.dart';
import 'package:movie_flutter/common/use_case/find_favorite_movie_summaries_use_case.dart';
import 'package:movie_flutter/common/use_case/is_movie_favorite_use_case.dart';
import 'package:movie_flutter/common/use_case/remove_favorite_movie_use_case.dart';
import 'package:movie_flutter/common/use_case/save_favorite_movie_use_case.dart';

export 'package:mockito/mockito.dart';

export '../test_utils/extensions/mockito_extensions.dart';
export '../test_utils/extensions/provider_extensions.dart';
export '../test_utils/factories.dart';
export 'mocks.mocks.dart';

@GenerateMocks(
  [
    MoviesRepository,
    EventBus,
    DateFormatter,
    FavoriteMovieSummaryStorage,
    FavoriteMovieStorage,
    SaveFavoriteMovieUseCase,
    IsMovieFavoriteUseCase,
    RemoveFavoriteMovieUseCase,
    FindFavoriteMovieSummariesUseCase,
  ],
  customMocks: [
    MockSpec<Storage>(
      onMissingStub: OnMissingStub.returnDefault,
      fallbackGenerators: {#name: name},
    ),
  ],
)
// not required for mocks
// ignore: no-empty-block
void main() {}

String name() => 'mock-name';

/// This custom implementation were required because of the following issues:
///
/// 1. We need to mock when a method is called because of mockito, after this
/// we already provide a custom default value "null" when this is called
/// without setting a stub
///
/// 2. The mocks generator have issues with generics, so the returned result
/// that it finds is always a ActionResult instead of the T value that we
/// expect and so without this override, we get a runtime error on tests
///    > The error that this fixes was:
///      `Future<Site<dynamic>?>' is not a subtype of type
///       'Future<HomeResult?>' in type cast`
class MockRouter extends Mock implements Router {
  @override
  Future<T?> pushTo<T extends SiteResult?>(
    Site<T>? route, {
    bool shouldShowAsDialog = false,
  }) async {
    final result = await super.noSuchMethod(Invocation.method(
      #pushTo,
      [route, shouldShowAsDialog],
    ));

    // Force the cast to T? to avoid returning an ActionResult
    // instead of the expected T
    return result as T?;
  }
}
