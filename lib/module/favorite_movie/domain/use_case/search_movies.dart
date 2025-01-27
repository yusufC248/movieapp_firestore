import '../../../movie/domain/entities/movie.dart';

class SearchMovies {
  List<Movie> call(List<Movie> allMovie, String query) {
    return allMovie
        .where((mv) =>
            '${mv.title}'.toLowerCase().contains(query.toLowerCase()) ||
            '${mv.overview}'.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
