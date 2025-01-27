import '../../../../core/config/endpoints.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoriesImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  // final SupabaseQueryBuilder supabase;

  MovieRepositoriesImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getMovies() async {
    final movieModels = await remoteDataSource.fetchMovies();

    return movieModels
        .map((model) => Movie(
              title: '${model.title}',
              backdrop: '${Endpoints.baseImage}${model.posterPath}',
              overview: '${model.overview}',
              id: model.id,
              poster: '${Endpoints.baseImage}${model.backdropPath}',
            ))
        .toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final movieModels = await remoteDataSource.fetcSearchhMovies(query);
    return movieModels
        .map((model) => Movie(
              title: '${model.title}',
              backdrop: '${Endpoints.baseImage}${model.posterPath}',
              overview: '${model.overview}',
              id: model.id,
              poster: '${Endpoints.baseImage}${model.backdropPath}',
            ))
        .toList();
  }
}
