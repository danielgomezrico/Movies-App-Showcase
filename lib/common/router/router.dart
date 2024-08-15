import 'package:flutter/material.dart';
import 'package:movie_flutter/common/result.dart';

import 'site.dart';
export 'site.dart';

class Router {
  const Router(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  String get initialRoute {
    return '/home';
  }

  Future<T?> pushTo<T extends SiteResult?>(Site<T> site) async {
    final pageRoute = site.asRoute();

    return await navigatorKey.currentState?.push(pageRoute);
  }

  Future<Result<T?>> replaceTo<T extends SiteResult>(Site<T> route) async {
    final siteResult = await navigatorKey.currentState!
        .pushAndRemoveUntil(route.asRoute(), (_) => false);

    return Result.ok(siteResult);
  }

  void pop<T extends Result<T>>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final Site<dynamic>? site;

    if (settings.name case '/home') {
      site = const HomeSite();
    } else {
      site = settings.arguments as Site<dynamic>?;
    }

    return site?.asRoute();
  }
}
