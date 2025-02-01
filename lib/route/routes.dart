import 'package:flutter/material.dart';
import '../module/auth/persentation/page/check_auth_screen.dart';
import '../module/auth/persentation/page/auth_screen.dart';

import '../component/nav/navigasi.dart';
import '../module/movie/presentation/pages/detail_page/movie_detail_page.dart';
import '../module/movie/presentation/pages/movie_page.dart';
import 'route_name.dart';

Map<String, dynamic>? args(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
}

final routes = {
  navigasiRoute: (context) => const Navigasi(),
  movieRoute: (context) => const MoviePage(),
  movieDetailRoute: (context) {
    return MovieDetailPage(
      mv: args(context)?['mv'],
    );
  },
  authRoute: (context) => const AuthScreen(),
  checkAuthRoute: (context) => const CheckAuthScreen()
};
