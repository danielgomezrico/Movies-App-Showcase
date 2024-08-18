import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'movie_detail_robot.dart';

class HomeRobot {
  const HomeRobot(this._tester);

  final WidgetTester _tester;

  Future<HomeRobot> tapBottomBar(HomeTab tab) async {
    final Key key;
    switch (tab) {
      case HomeTab.discover:
        key = const ValueKey('tab.discover');
      case HomeTab.favorites:
        key = const ValueKey('tab.favorites');
    }

    _tester.tap(find.byKey(key));
    await _tester.pumpAndSettle();

    return this;
  }

  Future<MovieDetailRobot> tapMovie(int index) async {
    final movieList = find.byKey(const ValueKey('movies.list')).evaluate();

    final item = movieList.last.widget;

    await _tester.tap(find.byWidget(item));
    await _tester.pumpAndSettle();

    return const MovieDetailRobot();
  }

  Future<HomeRobot> checkTabVisibility(HomeTab tab) async {
    final String text;
    switch (tab) {
      case HomeTab.discover:
        text = 'Discover';
      case HomeTab.favorites:
        text = 'Favorite Movies';
    }

    expect(find.text(text), findsOneWidget);

    return this;
  }
}

enum HomeTab { discover, favorites }
