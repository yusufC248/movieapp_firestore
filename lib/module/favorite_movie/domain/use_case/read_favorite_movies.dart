import '../../../movie/domain/entities/movie.dart';
import '../repositories/favorite_movie_repository.dart';

class ReadFavoriteMovies {
  final FavoriteMovieRepository repository;

  ReadFavoriteMovies(this.repository);

  Stream<List<Movie>> call() {
    return repository.getFavoiteMovies();
  }
}
