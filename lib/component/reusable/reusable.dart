import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color bgColor = const Color(0xfffafbfe);

Widget loading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget error(String message) {
  return Center(
    child: Text(message),
  );
}

Widget defaultText() {
  return const Center(child: Text('Press the button to fetch movies'));
}

Widget tombolRefresh(Function() onpressed) {
  return FloatingActionButton(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.black,
    onPressed: onpressed,
    child: const Icon(Icons.refresh),
  );
}

Widget gap() {
  return const SizedBox(
    height: 10,
  );
}

Widget movieNotFound() {
  return const Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.movie,
          size: 70,
        ),
        Text(
          "Movie Not Found",
          style: TextStyle(fontSize: 25),
        )
      ],
    ),
  );
}

Widget imageView(String url) {
  return Hero(
    tag: 'poster-path$url',
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}

PreferredSize searchMovieTextField(
    Function(String value) onChange, double height) {
  return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 23, left: 14, right: 14),
        child: TextField(
          onSubmitted: onChange,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search Movies...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
        ),
      ));
}

void showSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurpleAccent,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
}

Widget errorDialog(BuildContext context, String error) {
  return CupertinoAlertDialog(
    title: const Text('Oopss!'),
    content: Text(error),
    actions: [
      CupertinoDialogAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Close'),
      ),
    ],
  );
}
