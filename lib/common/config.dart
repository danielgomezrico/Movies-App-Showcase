// Every field in this config could come from a third party (like firebase remote config)
// and help us to do A/B tests
class Config {
  const Config();

  String apiKey() => '6bf6c64ac9b3bfc139606bcaca203f67';

  Uri apiBaseUrl() {
    return Uri.parse('https://api.themoviedb.org/3');
  }
}
