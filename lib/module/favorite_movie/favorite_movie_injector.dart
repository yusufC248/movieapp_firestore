import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/endpoints.dart';
import '../../core/injection/di.dart';
import 'data/repositories/favorite_movie_repository_impl.dart';
import 'domain/repositories/favorite_movie_repository.dart';
import 'domain/use_case/delete_saved_favorite.dart';
import 'domain/use_case/read_favorite_movies.dart';
import 'domain/use_case/save_favorite_movie.dart';
import 'domain/use_case/search_movies.dart';
import 'persentation/bloc/favorite_movie_bloc.dart';

Future<void> setupFavorite() async {
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection(Endpoints.collection);

  getIt
    ..registerLazySingleton<CollectionReference>(() => movieCollection)
    ..registerLazySingleton<FavoriteMovieRepository>(
        () => FavoriteMovieRepositoryImpl(getIt<CollectionReference>()))
    ..registerLazySingleton<ReadFavoriteMovies>(
        () => ReadFavoriteMovies(getIt<FavoriteMovieRepository>()))
    ..registerLazySingleton<SaveFavoriteMovie>(
        () => SaveFavoriteMovie(getIt<FavoriteMovieRepository>()))
    ..registerLazySingleton<DeleteSavedFavorite>(
        () => DeleteSavedFavorite(getIt<FavoriteMovieRepository>()))
    ..registerLazySingleton<SearchMovies>(() => SearchMovies())
    ..registerFactory<FavoriteMovieBloc>(() => FavoriteMovieBloc(
        getIt<ReadFavoriteMovies>(),
        getIt<SaveFavoriteMovie>(),
        getIt<DeleteSavedFavorite>(),
        getIt<SearchMovies>()));
}
