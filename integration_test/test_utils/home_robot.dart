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

  Future<HomeRobot> tapTab(int index) async {
    if (index == 0) {
      await tester.tap(find.byKey(const ValueKey('tab.discover')));
    } else {
      await tester.tap(find.byKey(const ValueKey('tab.favorites')));
    }

    await tester.pumpAndSettle();
    return this;
  }

  Future<HomeRobot> checkTabVisibility(int index) async {
    expect(find.text('Favorite Movies'), findsOneWidget);
    return this;
  }
}
