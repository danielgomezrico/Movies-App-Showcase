import 'package:flutter/material.dart'
    show MaterialPageRoute, PageRoute, RouteSettings, Widget;

export 'package:flutter/material.dart' show Widget;

export 'sites/home_site.dart';

abstract class Site<T extends SiteResult?> {
  const Site();

  Widget get widget;

  String get name;

  PageRoute<T> asRoute() {
    return MaterialPageRoute<T>(
      builder: (_) => widget,
      settings: RouteSettings(name: name, arguments: this),
    );
  }
}

abstract class SiteResult {
  const SiteResult();
}
