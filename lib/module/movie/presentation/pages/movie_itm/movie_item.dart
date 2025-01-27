import 'package:flutter/material.dart';

import '../../../../../component/reusable/reusable.dart';
import '../../../../../route/route_name.dart';
import '../../../domain/entities/movie.dart';
// import '../qr_dialog/show_qr_dialog.dart';

class MovieItem extends StatelessWidget {
  final Movie data;
  final bool? isFavorite;
  final Function()? functionTambah;
  final Function()? functionHapus;

  const MovieItem(
      {super.key,
      required this.data,
      this.isFavorite = false,
      this.functionTambah,
      this.functionHapus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => navigate(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_image(), _titleDesc(context), _button()],
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    Navigator.pushNamed(context, movieDetailRoute, arguments: {'mv': data});
  }

  Widget _image() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: 140,
          height: 200,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageView(
                '${data.backdrop}',
              ))),
    );
  }

  Widget _titleDesc(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Text(
              '${data.title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${data.overview}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, top: 25),
      child: IconButton(
          onPressed: (isFavorite != null && isFavorite == true)
              ? functionHapus
              : functionTambah,
          //onPressed: null,
          icon: Icon(
              isFavorite != null && isFavorite == true
                  ? Icons.delete
                  : data.isFavorite
                      ? Icons.favorite
                      : Icons.favorite,
              size: 30,
              color: Colors.red)),
    );
  }
}
