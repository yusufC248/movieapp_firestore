import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../component/reusable/reusable.dart';
import '../../../movie/domain/entities/movie.dart';
import '../../../movie/presentation/bloc/movie_state.dart';
import '../../../movie/presentation/pages/movie_itm/movie_item.dart';
import '../bloc/favorite_movie_bloc.dart';
import '../bloc/favorite_movie_event.dart';
import '../bloc/favorite_movie_state.dart';
import '../error_listen/favorite_error_listener.dart';

class FavoriteMoviePage extends StatefulWidget {
  const FavoriteMoviePage({super.key});

  @override
  State<FavoriteMoviePage> createState() => _FavoriteMoviePageState();
}

class _FavoriteMoviePageState extends State<FavoriteMoviePage>
    with WidgetsBindingObserver {
  String lifecycleState = "App is Active";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        lifecycleState = "App Resumed";
        break;
      case AppLifecycleState.inactive:
        lifecycleState = "App Inactive";
        break;
      case AppLifecycleState.paused:
        lifecycleState = "App Paused";

        break;
      case AppLifecycleState.detached:
        lifecycleState = "App Detached";
        break;
      default:
        lifecycleState = "Unknown State";
        break;
    }
    setState(() {});
    log('Current State: $state $lifecycleState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: _appBar((value) => _handleSearch(context, value)),
        body: lifecycleState == "App Inactive"
            ? Center(
                child: Text("INACTIVE"),
              )
            : MultiBlocListener(
                listeners: [favoriteErrorListener(context)],
                child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                    builder: (context, state) {
                  if (state is MovieLoading) {
                    return loading();
                  } else if (state is FavoriteMovieLoaded) {
                    if (state.movies.isNotEmpty) {
                      return _buildFavoriteMovieBody(context, state.movies);
                    }
                    return movieNotFound();
                  }
                  return defaultText();
                }),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: tombolRefresh(
          () => _handleFetchData(context),
        ));
  }

  AppBar _appBar(Function(String value) onChange) {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.amber,
      elevation: 0,
      title: const Text("Favorite Movies"),
      centerTitle: true,
      bottom: searchMovieTextField(onChange, 75),
      actions: [tombolLogout()],
    );
  }

  Widget _buildFavoriteMovieBody(BuildContext context, List<Movie> movies) {
    return LayoutBuilder(builder: (context, constraint) {
      return GridView.builder(
        gridDelegate: _gridSetup(constraint.maxWidth),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieItem(
            data: movie,
            isFavorite: true,
            functionHapus: () => _handleDelete(context, movie),
          );
        },
      );
    });
  }

  SliverGridDelegate _gridSetup(double maxWidth) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: (maxWidth / 350).toInt(),
      childAspectRatio: 1.9,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }

  void _handleFetchData(BuildContext context) {
    context.read<FavoriteMovieBloc>().add(FetchFavoriteMovies());
  }

  void _handleSearch(BuildContext context, String value) {
    context.read<FavoriteMovieBloc>().add(
        value.isNotEmpty ? SearchFavoriteMovies(value) : FetchFavoriteMovies());
  }

  void _handleDelete(BuildContext context, Movie movie) {
    context.read<FavoriteMovieBloc>().add(DeleteFavorite('${movie.id}'));
    String msg = '${movie.title} dihapus dari Favorite';
    showSnackbar(context, msg);
  }
}
