import 'package:movie_flutter/common/di/api_modules.dart';
import 'package:movie_flutter/widgets/movie_showcase/movie_showcase_view_model.dart';

abstract class ViewModelModules {
  static MovieShowcaseViewModel movieShowcaseViewModel() {
    return MovieShowcaseViewModel(
      ApiModules.moviesRepository(),
    );
  }
}
