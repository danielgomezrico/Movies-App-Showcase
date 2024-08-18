import 'package:flutter_test/flutter_test.dart';

class MovieDetailRobot {
  const MovieDetailRobot();

  MovieDetailRobot checkVisibility() {
    expect(find.text('Overview'), findsOneWidget);

    return this;
  }
}
