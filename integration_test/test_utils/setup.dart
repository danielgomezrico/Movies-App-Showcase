import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/main.dart';

import 'robot/robots.dart';

Future<HomeRobot> prepareTests(WidgetTester tester) async {
  await setupServices();

  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();

  return HomeRobot(tester);
}
