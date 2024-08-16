// This is the mock setup and its not required
// ignore_for_file: prefer-correct-test-file-name

import 'package:mockito/annotations.dart';
import 'package:movie_flutter/api/repositories/movies_repository.dart';
import 'package:movie_flutter/common/database/storage.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/router/router.dart';
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
    Router,
    DateFormatter,
    SaveFavoriteMovieUseCase,
    IsMovieFavoriteUseCase,
    RemoveFavoriteMovieUseCase,
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
