import 'package:movie_flutter/common/config.dart';
import 'package:movie_flutter/common/di/flutter_module.dart';
import 'package:movie_flutter/common/router/router.dart';

abstract class CommonModule {
  static Router router() {
    return Router(FlutterModule.navigatorKey());
  }

  static Config config() {
    return const Config();
  }
}
