import 'package:get_it/get_it.dart';
import '../../module/auth/auth_injector.dart';
import '../../module/favorite_movie/favorite_movie_injector.dart';

import '../../module/movie/movie_injector.dart';

final getIt = GetIt.instance;

Future<void> setupAllDI() async {
  await setupMovieDI();
  await setupFavorite();
  await setupAuth();
}
