import '../../../movie/domain/entities/movie.dart';
import '../repositories/favorite_movie_repository.dart';

class SaveFavoriteMovie {
  final FavoriteMovieRepository repository;

  SaveFavoriteMovie(this.repository);

  Future<void> call(Movie movie) async {
    await repository.addFavoriteMovies(movie);
  }
}
