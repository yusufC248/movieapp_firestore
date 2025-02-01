import 'package:flutter_bloc/flutter_bloc.dart';

import '../../module/auth/persentation/bloc/auth_bloc.dart';
import '../../module/favorite_movie/persentation/bloc/favorite_movie_bloc.dart';
import '../../module/favorite_movie/persentation/bloc/favorite_movie_event.dart';
import '../../module/movie/presentation/bloc/movie_bloc.dart';
import '../../module/movie/presentation/bloc/movie_event.dart';
import '../injection/di.dart';

final providers = [
  BlocProvider<MovieBloc>(
    create: (_) => getIt<MovieBloc>()..add(FetchMovies()),
  ),
  BlocProvider<FavoriteMovieBloc>(
    create: (_) => getIt<FavoriteMovieBloc>()..add(FetchFavoriteMovies()),
  ),
  BlocProvider<AuthBloc>(
    create: (_) => getIt<AuthBloc>(),
  ),
];
