import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/result.dart';

const _imageUrl = 'https://image.tmdb.org/t/p/w500';

class MoviesRepository {
  Future<Result<List<MovieSummary>>> movies() async {
    return Result.ok(
      const [
        MovieSummary('$_imageUrl/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg'),
        MovieSummary('$_imageUrl/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg'),
        MovieSummary('$_imageUrl/oGythE98MYleE6mZlGs5oBGkux1.jpg'),
        MovieSummary('$_imageUrl/wWba3TaojhK7NdycRhoQpsG0FaH.jpg'),
        MovieSummary('$_imageUrl/yrpPYKijwdMHyTGIOd1iK1h0Xno.jpg'),
        MovieSummary('$_imageUrl/30YnfZdMNIV7noWLdvmcJS0cbnQ.jpg'),
        MovieSummary('$_imageUrl/5wAlO5zZ3IyzLBAf7cp5WejalmG.jpg'),
        MovieSummary('$_imageUrl/AjV6jFJ2YFIluYo4GQf13AA1tqu.jpg'),
        MovieSummary('$_imageUrl/xYduFGuch9OwbCOEUiamml18ZoB.jpg'),
        MovieSummary('$_imageUrl/pjnD08FlMAIXsfOLKQbvmO0f0MD.jpg'),
        MovieSummary('$_imageUrl/e5ZqqPlhKstzB4geibpZh38w7Pq.jpg'),
        MovieSummary('$_imageUrl/t9u9FWpKlZcp0Wz1qPeV5AIzDsk.jpg'),
        MovieSummary('$_imageUrl/8aF0iAKH9MJMYAZdi0Slg77RYa2.jpg'),
        MovieSummary('$_imageUrl/6yK9hmS641NMwRkR1wWAALWI34t.jpg'),
        MovieSummary('$_imageUrl/gKkl37BQuKTanygYQG1pyYgLVgf.jpg'),
        MovieSummary('$_imageUrl/bbpMHWCqrcMaaYLibIinIMvhI9u.jpg'),
        MovieSummary('$_imageUrl/iADOJ8Zymht2JPMoy3R7xceZprc.jpg'),
        MovieSummary('$_imageUrl/koJFEW997sLjpu4e7wmFioA2mhL.jpg'),
        MovieSummary('$_imageUrl/bHQG4UsLMFCy91gfLAFRpnCOPdP.jpg'),
        MovieSummary('$_imageUrl/nZQPbD7IEKWiUDK7s9GKHwqP88g.jpg'),
      ],
    );
  }

  Future<Result<Movie>> movie(String movieId) {
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
