import 'package:dio/dio.dart';

import '../../../../core/config/endpoints.dart';
import '../models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio dio;
  MovieRemoteDataSource(this.dio);

  Future<List<Result>> fetchMovies() async {
    final response = await dio.get('${Endpoints.baseUrl}${Endpoints.getMovies}',
        options:
            Options(headers: {'Authorization': 'Bearer ${Endpoints.apiKey}'}));

    if (response.statusCode == 200) {
      final List result = response.data['results'];

      return result.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Result>> fetcSearchhMovies(String query) async {
    final response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.searchMoviesUrl}$query',
        options:
            Options(headers: {'Authorization': 'Bearer ${Endpoints.apiKey}'}));

    if (response.statusCode == 200) {
      final List result = response.data['results'];

      return result.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
