import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/result.dart';

const _imageUrl = 'https://image.tmdb.org/t/p/w500';

class MoviesRepository {
  const MoviesRepository();

  Future<Result<List<MovieSummary>>> movies() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return Result.ok(
      const [
        MovieSummary('$_imageUrl/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg', 'Star Wars', 3.4,  100),
        MovieSummary('$_imageUrl/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg', 'The Lord of the Rings', 4.5,  200),
        MovieSummary('$_imageUrl/oGythE98MYleE6mZlGs5oBGkux1.jpg', 'The Matrix', 4.0,  300),
        MovieSummary('$_imageUrl/wWba3TaojhK7NdycRhoQpsG0FaH.jpg', 'The Godfather', 4.8,  400),
        MovieSummary('$_imageUrl/yrpPYKijwdMHyTGIOd1iK1h0Xno.jpg', 'The Shawshank Redemption', 4.9,  500),
        MovieSummary('$_imageUrl/30YnfZdMNIV7noWLdvmcJS0cbnQ.jpg', 'The Dark Knight', 4.7,  600),
        MovieSummary('$_imageUrl/5wAlO5zZ3IyzLBAf7cp5WejalmG.jpg', 'Inception', 4.6,  700),
        MovieSummary('$_imageUrl/AjV6jFJ2YFIluYo4GQf13AA1tqu.jpg', 'The Lord of the Rings: The Return of the King', 4.5,  800),
        MovieSummary('$_imageUrl/xYduFGuch9OwbCOEUiamml18ZoB.jpg', 'The Lord of the Rings: The Fellowship of the Ring', 4.5,  900),
        MovieSummary('$_imageUrl/pjnD08FlMAIXsfOLKQbvmO0f0MD.jpg', 'The Lord of the Rings: The Two Towers', 4.5,  1000),
        MovieSummary('$_imageUrl/e5ZqqPlhKstzB4geibpZh38w7Pq.jpg', 'Other', 4.5,  1100),
        MovieSummary('$_imageUrl/t9u9FWpKlZcp0Wz1qPeV5AIzDsk.jpg', 'Other other', 4.5,  1200),
        MovieSummary('$_imageUrl/8aF0iAKH9MJMYAZdi0Slg77RYa2.jpg', 'To many words, the bigger title cases', 4.5,  1300),
        MovieSummary('$_imageUrl/6yK9hmS641NMwRkR1wWAALWI34t.jpg', 'Other other other', 4.5,  1400),
        MovieSummary('$_imageUrl/gKkl37BQuKTanygYQG1pyYgLVgf.jpg', 'Other other other other', 4.5,  1500),
        MovieSummary('$_imageUrl/bbpMHWCqrcMaaYLibIinIMvhI9u.jpg', 'Other other other other other', 4.5,  1600),
        MovieSummary('$_imageUrl/iADOJ8Zymht2JPMoy3R7xceZprc.jpg', 'Other other other other other other', 4.5,  1700),
        MovieSummary('$_imageUrl/koJFEW997sLjpu4e7wmFioA2mhL.jpg', 'Other other other other other other other', 4.5,  1800),
        MovieSummary('$_imageUrl/bHQG4UsLMFCy91gfLAFRpnCOPdP.jpg', 'Other other other other other other other other', 4.5,  1900),
        MovieSummary('$_imageUrl/nZQPbD7IEKWiUDK7s9GKHwqP88g.jpg', 'Other other other other other other other other other', 4.5,  2000),
      ],
    );
  }

  Future<Result<Movie>> movie(String movieId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final movie = Movie(
      name: 'Star Wars',
      posterUrl: '$_imageUrl/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      genres: ['drama', 'si-phy'],
      overview: 'Important movie from the 90s, it '
          'was a revolution in the movie industry'
          ' and it has a lot of fans around the world.',
      releaseDate: DateTime.now(),
      languages: ['es', 'co'],
      voteAverage: 2.3,
    );

    return Future.value(Result.ok(movie));
  }
}
