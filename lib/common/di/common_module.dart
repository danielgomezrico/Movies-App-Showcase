import 'package:movie_flutter/common/di/flutter_module.dart';
import 'package:movie_flutter/common/router/router.dart';

abstract class CommonModule {
  static Router router() {
    return Router(FlutterModule.navigatorKey());
  }
}
