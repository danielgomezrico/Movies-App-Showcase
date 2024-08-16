import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_flutter/common/result.dart';

class Config {
  const Config();

  Future<EmptyResult> setup() async {
    try {
      await dotenv.load(fileName: 'assets/.env');

      return Result.ok(const EmptyContent());
    } catch (e) {
      return Result.error(e);
    }
  }

  // Every field in this config could come from a third party
  // (like firebase remote config) and help us to do A/B tests
  // and also it will not be hardcoded
  String apiKey() => dotenv.env['MOVIES_API_KEY']!;

  Uri apiBaseUrl() {
    final url = dotenv.env['API_URL']!;
    return Uri.parse(url);
  }
}
