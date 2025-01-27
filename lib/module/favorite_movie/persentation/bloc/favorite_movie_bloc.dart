import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/search_movies.dart';
import '../../domain/use_case/delete_saved_favorite.dart';
import '../../domain/use_case/read_favorite_movies.dart';
import '../../domain/use_case/save_favorite_movie.dart';
import 'favorite_movie_event.dart';
import 'favorite_movie_state.dart';
import '../../../movie/domain/entities/movie.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final ReadFavoriteMovies readFavoriteMovies;
  final SaveFavoriteMovie saveFavoriteMovie;
  final DeleteSavedFavorite deleteSavedFavorite;
  final SearchMovies searchMovies;

  List<Movie> allMovies = [];

  FavoriteMovieBloc(this.readFavoriteMovies, this.saveFavoriteMovie,
      this.deleteSavedFavorite, this.searchMovies)
      : super(FavoriteMovieInitial()) {
    on<FetchFavoriteMovies>(_onFetchFavoriteMovie);
    on<SaveFavorite>(_onSaveFavoriteMovie);
    on<DeleteFavorite>(_onDeleteFavoriteMovie);
    on<SearchFavoriteMovies>(_onSearchFavoriteMovie);
  }

  Future<void> _onFetchFavoriteMovie(
      FetchFavoriteMovies event, Emitter<FavoriteMovieState> emit) async {
    try {
      emit(FavoriteMovieLoading());
      final stream = readFavoriteMovies();
      await emit.forEach<List<Movie>>(stream, onData: (mv) {
        allMovies = mv;
        return FavoriteMovieLoaded(mv);
      });
    } catch (e) {
      emit(FavoriteMovieError(e.toString()));
    }
  }

  Future<void> _onSaveFavoriteMovie(
      SaveFavorite event, Emitter<FavoriteMovieState> emit) async {
    try {
      await saveFavoriteMovie(event.movie);
    } catch (e) {
      emit(FavoriteMovieError(e.toString()));
    }
  }

  Future<void> _onDeleteFavoriteMovie(
      DeleteFavorite event, Emitter<FavoriteMovieState> emit) async {
    try {
      await deleteSavedFavorite(event.index);
    } catch (e) {
      emit(FavoriteMovieError(e.toString()));
    }
  }

  Future<void> _onSearchFavoriteMovie(
      SearchFavoriteMovies event, Emitter<FavoriteMovieState> emit) async {
    try {
      final movie = searchMovies(allMovies, event.query);
      emit(FavoriteMovieLoaded(movie));
    } catch (e) {
      emit(FavoriteMovieError(e.toString()));
    }
  }
}
