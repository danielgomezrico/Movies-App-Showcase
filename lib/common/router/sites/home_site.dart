import 'package:movie_flutter/common/router/site.dart';
import 'package:movie_flutter/features/home/home_page.dart';

class HomeSite extends Site {
  const HomeSite();

  @override
  String get name => 'HOME';

  @override
  Widget get widget => const HomePage();
}
