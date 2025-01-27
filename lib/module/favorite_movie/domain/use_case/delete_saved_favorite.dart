import '../repositories/favorite_movie_repository.dart';

class DeleteSavedFavorite {
  final FavoriteMovieRepository repository;

  DeleteSavedFavorite(this.repository);

  Future<void> call(String index) async {
    await repository.deleteFavoriteMovies(index);
  }
}
