import 'package:dio/dio.dart';

import '../../core/injection/di.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repositories_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/use_case/get_movies.dart';
import 'domain/use_case/search_movies.dart';
import 'presentation/bloc/movie_bloc.dart';

Future<void> setupMovieDI() async {
  getIt
    ..registerLazySingleton<Dio>(
        // () => Dio(BaseOptions(baseUrl: Endpoints.baseUrl)))
        () => Dio())
    ..registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSource(getIt<Dio>()))
    ..registerLazySingleton<MovieRepository>(
        () => MovieRepositoriesImpl(getIt<MovieRemoteDataSource>()))
    ..registerLazySingleton<GetMovies>(
        () => GetMovies(getIt<MovieRepository>()))
    ..registerLazySingleton<SearchMoviesNew>(
        () => SearchMoviesNew(getIt<MovieRepository>()))
    ..registerFactory<MovieBloc>(() => MovieBloc(
          getIt<GetMovies>(),
          getIt<SearchMoviesNew>(),
        ));
}
