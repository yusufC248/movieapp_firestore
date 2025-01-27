import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../component/reusable/reusable.dart';
import '../../bloc/movie_bloc.dart';
import '../../bloc/movie_state.dart';

BlocListener errorListen(BuildContext context) {
  return BlocListener<MovieBloc, MovieState>(listener: (context, state) {
    if (state is MovieError) {
      showCupertinoDialog(
          context: context,
          builder: (context) => errorDialog(context, state.message));
    }
  });
}
