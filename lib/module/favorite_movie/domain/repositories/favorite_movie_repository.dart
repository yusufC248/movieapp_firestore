import '../../../movie/domain/entities/movie.dart';

abstract class FavoriteMovieRepository {
  Stream<List<Movie>> getFavoiteMovies();
  Future<void> addFavoriteMovies(Movie movie);
  Future<void> deleteFavoriteMovies(String id);
}
