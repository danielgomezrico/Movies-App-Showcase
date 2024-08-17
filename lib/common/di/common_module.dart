import 'package:movie_flutter/api/repositories/storages/favorite_movie_storage.dart';
import 'package:movie_flutter/api/repositories/storages/favorite_movie_summary_storage.dart';
import 'package:movie_flutter/common/config.dart';
import 'package:movie_flutter/common/database/database.dart';
import 'package:movie_flutter/common/database/storage.dart';
import 'package:movie_flutter/common/date_formatter.dart';
import 'package:movie_flutter/common/di/flutter_module.dart';
import 'package:movie_flutter/common/event_bus.dart';
import 'package:movie_flutter/common/router/router.dart';

abstract class CommonModule {
  static Router router() {
    return Router(FlutterModule.navigatorKey());
  }

  static Config config() {
    return const Config();
  }

  static DateFormatter dateFormatter() {
    return const DateFormatter();
  }

  static List<Storage> storages() {
    return [
      FavoriteMovieStorage(),
      FavoriteMovieSummaryStorage(),
    ];
  }

  static FavoriteMovieStorage favoriteMovieStorage() {
    return Database.storage<FavoriteMovieStorage>();
  }

  static FavoriteMovieSummaryStorage favoriteMovieSummaryStorage() {
    return Database.storage<FavoriteMovieSummaryStorage>();
  }

  static EventBus eventBus() {
    return EventBus.instance;
  }
}
