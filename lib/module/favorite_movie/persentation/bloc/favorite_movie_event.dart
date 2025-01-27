import '../../../movie/domain/entities/movie.dart';

abstract class FavoriteMovieEvent {}

class FetchFavoriteMovies extends FavoriteMovieEvent {}

class SaveFavorite extends FavoriteMovieEvent {
  final Movie movie;
  SaveFavorite(this.movie);
}

class DeleteFavorite extends FavoriteMovieEvent {
  final String index;
  DeleteFavorite(this.index);
}

class SearchFavoriteMovies extends FavoriteMovieEvent {
  final String query;
  SearchFavoriteMovies(this.query);
}
