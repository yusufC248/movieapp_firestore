import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static String get filename {
    if (kReleaseMode) {
      return ".env.prod";
    }
    return ".env.dev";
  }

  static String collection = dotenv.get('COLLECTION', fallback: null);
  static String baseUrl = dotenv.get('BASE_URL', fallback: null);
  static String apiKey = dotenv.get('API_KEY', fallback: null);
  static String getMovies = dotenv.get('GET_MOVIES_URL', fallback: null);
  static String searchMoviesUrl =
      dotenv.get('SEARCH_MOVIES_URL', fallback: null);

  static const String baseImage = 'https://image.tmdb.org/t/p/w500';
}
