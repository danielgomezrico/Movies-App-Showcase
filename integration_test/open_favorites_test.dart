import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_utils/robot/robots.dart';
import 'test_utils/setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('in the list of movies', () {
    testWidgets('can open a detail for a movie', (tester) async {
      final homeRobot = await prepareTests(tester);

      await homeRobot.tapBottomBar(HomeTab.favorites).then((_) {
        return homeRobot.checkTabVisibility(HomeTab.favorites);
      });
    });
  });

  group('can open a movie detail from the list', () {
    testWidgets('can open a detail for a movie', (tester) async {
      final homeRobot = await prepareTests(tester);

      await homeRobot.tapMovie(0).then((movieDetailRobot) {
        return movieDetailRobot.checkVisibility();
      });
    });
  });
}
