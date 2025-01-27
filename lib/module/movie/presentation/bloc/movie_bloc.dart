import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/use_case/get_movies.dart';
import '../../domain/use_case/search_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;

  final SearchMoviesNew searchMoviesNew;

  List<Movie> allMovies = [];

  MovieBloc(this.getMovies, this.searchMoviesNew) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);

    on<FetchSearchMovies>(_onFetchSearchMovies);
  }

  Future<void> _onFetchMovies(
      FetchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      var movie = await getMovies();
      allMovies = movie;
      emit(MovieLoaded(allMovies));
    } on DioException catch (e) {
      emit(MovieError('${e.message}'));
    }
  }

  Future<void> _onFetchSearchMovies(
      FetchSearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      var loadedMovie = allMovies;
      var movie = await searchMoviesNew(event.query);
      emit(MovieLoaded(event.query.isEmpty ? loadedMovie : movie));
    } catch (e) {
      log('error ya');
      emit(MovieError('$e'));
    }
  }
}
