import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/di/api_module.dart';
import 'package:movie_flutter/features/movie_detail/movie_detail_view_model.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_view_model.dart';

abstract class ViewModelModule {
  static MovieShowcaseViewModel movieShowcaseViewModel() {
    return MovieShowcaseViewModel(
      ApiModule.moviesRepository(),
    );
  }

  static MovieDetailViewModel movieDetailViewModel(MovieSummary movieSummary) {
    return MovieDetailViewModel(
      ApiModule.moviesRepository(),
      movieSummary,
    );
  }
}
