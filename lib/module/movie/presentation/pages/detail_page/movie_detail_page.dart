import 'package:flutter/material.dart';

import '../../../../../component/reusable/reusable.dart';
import '../../../domain/entities/movie.dart';
import '../qr_dialog/show_qr_dialog.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie? mv;
  const MovieDetailPage({super.key, this.mv});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('${mv?.title}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
                margin: const EdgeInsets.all(12),
                width: maxWidth < 600 ? maxWidth : 300,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: imageView('${mv?.backdrop}'))),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "${mv?.overview}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => QRDetail(data: '${mv?.id}'));
        },
        child: const Icon(
          Icons.qr_code,
          size: 30,
        ),
      ),
    );
  }
}
