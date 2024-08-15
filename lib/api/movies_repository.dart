import 'package:movie_flutter/api/models.dart';
import 'package:movie_flutter/common/result.dart';

const _imageUrl = 'https://image.tmdb.org/t/p/w500';

class MoviesRepository {
  const MoviesRepository();

  Future<PagedResult<List<MovieSummary>>> movies(int currentPage) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    const movies = [
      MovieSummary(
        url: '$_imageUrl/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
        title: 'Star Wars',
        voteAverage: .4,
        voteCount: 100,
      ),
      MovieSummary(
        url: '$_imageUrl/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
        title: 'The Lord of the Rings',
        voteAverage: .5,
        voteCount: 200,
      ),
      MovieSummary(
        url: '$_imageUrl/oGythE98MYleE6mZlGs5oBGkux1.jpg',
        title: 'The Matrix',
        voteAverage: .0,
        voteCount: 300,
      ),
      MovieSummary(
        url: '$_imageUrl/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
        title: 'The Godfather',
        voteAverage: .8,
        voteCount: 400,
      ),
      MovieSummary(
        url: '$_imageUrl/yrpPYKijwdMHyTGIOd1iK1h0Xno.jpg',
        title: 'The Shawshank Redemption',
        voteAverage: .9,
        voteCount: 500,
      ),
      MovieSummary(
        url: '$_imageUrl/30YnfZdMNIV7noWLdvmcJS0cbnQ.jpg',
        title: 'The Dark Knight',
        voteAverage: .7,
        voteCount: 600,
      ),
      MovieSummary(
        url: '$_imageUrl/5wAlO5zZ3IyzLBAf7cp5WejalmG.jpg',
        title: 'Inception',
        voteAverage: .6,
        voteCount: 700,
      ),
      MovieSummary(
        url: '$_imageUrl/AjV6jFJ2YFIluYo4GQf13AA1tqu.jpg',
        title: 'The Lord of the Rings: The Return of the King',
        voteAverage: .5,
        voteCount: 800,
      ),
      MovieSummary(
        url: '$_imageUrl/xYduFGuch9OwbCOEUiamml18ZoB.jpg',
        title: 'The Lord of the Rings: The Fellowship of the Ring',
        voteAverage: .5,
        voteCount: 900,
      ),
      MovieSummary(
        url: '$_imageUrl/pjnD08FlMAIXsfOLKQbvmO0f0MD.jpg',
        title: 'The Lord of the Rings: The Two Towers',
        voteAverage: .5,
        voteCount: 1000,
      ),
      MovieSummary(
        url: '$_imageUrl/e5ZqqPlhKstzB4geibpZh38w7Pq.jpg',
        title: 'Other',
        voteAverage: .5,
        voteCount: 1100,
      ),
      MovieSummary(
        url: '$_imageUrl/t9u9FWpKlZcp0Wz1qPeV5AIzDsk.jpg',
        title: 'Other other',
        voteAverage: .5,
        voteCount: 1200,
      ),
      MovieSummary(
        url: '$_imageUrl/8aF0iAKH9MJMYAZdi0Slg77RYa2.jpg',
        title: 'To many words, the bigger title cases',
        voteAverage: .5,
        voteCount: 1300,
      ),
      MovieSummary(
        url: '$_imageUrl/6yK9hmS641NMwRkR1wWAALWI34t.jpg',
        title: 'Other other other',
        voteAverage: .5,
        voteCount: 1400,
      ),
      MovieSummary(
        url: '$_imageUrl/gKkl37BQuKTanygYQG1pyYgLVgf.jpg',
        title: 'Other other other other',
        voteAverage: .5,
        voteCount: 1500,
      ),
      MovieSummary(
        url: '$_imageUrl/bbpMHWCqrcMaaYLibIinIMvhI9u.jpg',
        title: 'Other other other other other',
        voteAverage: .5,
        voteCount: 1600,
      ),
      MovieSummary(
        url: '$_imageUrl/iADOJ8Zymht2JPMoy3R7xceZprc.jpg',
        title: 'Other other other other other other',
        voteAverage: .5,
        voteCount: 1700,
      ),
      MovieSummary(
        url: '$_imageUrl/koJFEW997sLjpu4e7wmFioA2mhL.jpg',
        title: 'Other other other other other other other',
        voteAverage: .5,
        voteCount: 1800,
      ),
      MovieSummary(
        url: '$_imageUrl/bHQG4UsLMFCy91gfLAFRpnCOPdP.jpg',
        title: 'Other other other other other other other other',
        voteAverage: .5,
        voteCount: 1900,
      ),
      MovieSummary(
        url: '$_imageUrl/nZQPbD7IEKWiUDK7s9GKHwqP88g.jpg',
        title: 'Other other other other other other other other other',
        voteAverage: .5,
        voteCount: 2000,
      ),
    ];

    final pagedMovies = movies.skip((currentPage - 1) * 5).take(5).toList();

    return PagedResult.ok(
      PagedContent(
        page: currentPage,
        totalPages: 4,
        totalResults: pagedMovies.length,
        payload: pagedMovies,
      ),
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
