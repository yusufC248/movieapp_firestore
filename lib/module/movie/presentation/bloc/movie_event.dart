abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

class FetchSearchMovies extends MovieEvent {
  final String query;

  FetchSearchMovies(this.query);
}

class Search extends MovieEvent {
  final String query;

  Search(this.query);
}
