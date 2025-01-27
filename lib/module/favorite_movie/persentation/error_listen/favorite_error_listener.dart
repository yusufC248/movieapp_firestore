import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorite_movie_bloc.dart';
import '../bloc/favorite_movie_state.dart';

import '../../../../component/reusable/reusable.dart';

BlocListener favoriteErrorListener(BuildContext context) {
  return BlocListener<FavoriteMovieBloc, FavoriteMovieState>(
      listener: (context, state) {
    if (state is FavoriteMovieError) {
      showCupertinoDialog(
          context: context,
          builder: (context) => errorDialog(context, state.message));
    }
  });
}
