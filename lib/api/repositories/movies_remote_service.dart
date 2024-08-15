import 'package:chopper/chopper.dart';
import 'package:movie_flutter/api/repositories/models/movie.dart';
import 'package:movie_flutter/api/repositories/models/movie_summary_response.dart';

part 'movies_remote_service.chopper.dart';

@ChopperApi()
abstract class MoviesRemoteService extends ChopperService {
  static MoviesRemoteService create([ChopperClient? client]) =>
      _$MoviesRemoteService(client);

  @Get(path: '/movie/{id}')
  Future<Response<Movie>> fetchMovie(@Path() int id);

  @Get(
      path:
          '/discover/movie?include_adult=true&include_video=false&language=en-US&sort_by=popularity.desc')
  Future<Response<MovieSummaryResponse>> fetchMovies(@Query('page') int page);
}
