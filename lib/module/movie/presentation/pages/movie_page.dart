import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../component/reusable/reusable.dart';
import '../../../favorite_movie/persentation/bloc/favorite_movie_bloc.dart';
import '../../../favorite_movie/persentation/bloc/favorite_movie_event.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import 'error_listener/error_listener.dart';
import 'movie_itm/movie_item.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.amber,
          title: const Text("Popular Movies"),
          centerTitle: true,
          bottom: searchMovieTextField(
              (query) => movieBloc.add(FetchSearchMovies(query)), 75),
          actions: [tombolLogout()],
        ),
        body: MultiBlocListener(
          listeners: [errorListen(context)],
          child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            if (state is MovieLoading) {
              return loading();
            } else if (state is MovieLoaded) {
              if (state.movies.isNotEmpty) {
                return LayoutBuilder(builder: (context, constraint) {
                  return GridView.builder(
                    gridDelegate: _gridSetup(constraint.maxWidth),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieItem(
                        data: movie,
                        functionTambah: () {
                          context
                              .read<FavoriteMovieBloc>()
                              .add(SaveFavorite(movie));
                          String msg = '${movie.title} ditambahkan ke Favorite';
                          if (movie.isFavorite == true) {
                            msg = '${movie.title} dihapus dari Favorite';
                          }
                          showSnackbar(context, msg);
                        },
                      );
                    },
                  );
                });
              }
              return movieNotFound();
            }
            return defaultText();
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:
            tombolRefresh(() => movieBloc.add(FetchMovies())));
  }

  SliverGridDelegate _gridSetup(double maxWidth) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: (maxWidth / 350).toInt(),
      childAspectRatio: 1.9,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }
}
