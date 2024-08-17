import 'package:chopper/chopper.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_sort.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary_response.dart';

part 'movies_remote_service.chopper.dart';

@ChopperApi()
abstract class MoviesRemoteService extends ChopperService {
  static MoviesRemoteService create([ChopperClient? client]) =>
      _$MoviesRemoteService(client);

  @Get(path: 'movie/{id}')
  Future<Response<Movie>> fetchMovie(@Path() int id);

  @Get(
    path:
        'discover/movie?include_adult=true&include_video=false&language=en-US&with_release_type=2|3',
  )
  Future<Response<MovieSummaryResponse>> fetchMovies(
    @Query('page') int page,
    @Query('sort_by') MovieSort sort,
  );

  @Get(
    path:
        'discover/movie?include_adult=false&include_video=false&language=en-US&with_release_type=2|3',
  )
  Future<Response<MovieSummaryResponse>> fetchMoviesInReleaseDate(
    @Query('page') int page,
    @Query('sort_by') MovieSort sort,
    @Query('release_date.gte') String minDate,
    @Query('release_date.lte') String maxDate,
  );
}
