import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../module/auth/auth_injector.dart';
import '../../module/favorite_movie/favorite_movie_injector.dart';

import '../../module/movie/movie_injector.dart';
import '../config/endpoints.dart';

const bool USE_EMULATOR = true;

final getIt = GetIt.instance;

Future<void> setupAllDI() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';

  final firestoreInit = FirebaseFirestore.instance;
  var authInit = FirebaseAuth.instance;

  if (USE_EMULATOR) {
    firestoreInit.settings = Settings(
        host: '$localHostString:8080',
        sslEnabled: false,
        persistenceEnabled: false);

    await authInit.useAuthEmulator(localHostString, 9099);
  }

  final CollectionReference movieCollection =
      firestoreInit.collection(Endpoints.collection);

  getIt
    ..registerLazySingleton<FirebaseAuth>(() => authInit)
    ..registerLazySingleton<CollectionReference>(() => movieCollection);

  await setupAuth();
  await setupMovieDI();
  await setupFavorite();
}
