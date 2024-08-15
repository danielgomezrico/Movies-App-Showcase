class MovieSummary {
  const MovieSummary(
      this.url,
      this.title,

    this.voteAverage,
    this.voteCount,
  );

  final String title;
  final double voteAverage;
  final int voteCount;
  final String url;
}

class Movie {
  const Movie({
    required this.name,
    required this.posterUrl,
    required this.genres,
    required this.overview,
    required this.releaseDate,
    required this.languages,
    required this.voteAverage,
  });

  final String name;
  final String posterUrl;
  final List<String> genres;
  final String overview;
  final DateTime releaseDate;
  final List<String> languages;
  final double voteAverage;
}
