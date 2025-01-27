import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMoviesNew {
  final MovieRepository repository;

  SearchMoviesNew(this.repository);

  Future<List<Movie>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
