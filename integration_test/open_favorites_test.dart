import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_utils/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('in the list of movies', () {
    testWidgets('can open a detail for a movie', (tester) async {
      final homeRobot = await prepareTests(tester);
      await homeRobot.tapTab(HomeTab.favorites);
      homeRobot.checkTabVisibility(HomeTab.favorites);
    });
  });
}
