import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../movie/domain/entities/movie.dart';
import '../../domain/repositories/favorite_movie_repository.dart';

class FavoriteMovieRepositoryImpl implements FavoriteMovieRepository {
  final CollectionReference movieCollection;

  FavoriteMovieRepositoryImpl(this.movieCollection);

  @override
  Stream<List<Movie>> getFavoiteMovies() {
    return movieCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Movie.fromJson(doc.data() as Map<String, dynamic>)
              //.copyWith(idFirestore: doc.id)
              )
          .toList();
    });
  }

  @override
  Future<void> addFavoriteMovies(Movie movie) async {
    await movieCollection.doc('${movie.id}').set(movie.toJson());
    // .add(movie.toJson());
  }

  @override
  Future<void> deleteFavoriteMovies(String id) async {
    await movieCollection.doc(id).delete();
  }
}
