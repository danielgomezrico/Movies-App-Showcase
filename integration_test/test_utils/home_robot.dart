import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/main.dart';

Future<HomeRobot> prepareTests(WidgetTester tester) async {
  await setupServices();

  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();

  return HomeRobot(tester);
}

class HomeRobot {
  const HomeRobot(this.tester);

  final WidgetTester tester;

  Future<HomeRobot> tapTab(HomeTab tab) async {
    final Key key;
    switch (tab) {
      case HomeTab.discover:
        key = const ValueKey('tab.discover');
      case HomeTab.favorites:
        key = const ValueKey('tab.favorites');
    }

    tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    return this;
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
