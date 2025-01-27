import '../../../movie/domain/entities/movie.dart';

abstract class FavoriteMovieState {}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMovieLoading extends FavoriteMovieState {}

class FavoriteMovieError extends FavoriteMovieState {
  final String message;
  FavoriteMovieError(this.message);
}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<Movie> movies;
  FavoriteMovieLoaded(this.movies);
}
