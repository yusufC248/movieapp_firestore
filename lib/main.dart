import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/config/endpoints.dart';
import 'core/injection/di.dart';
import 'core/providers/providers.dart';
import 'firebase_options.dart';
import 'route/route_name.dart';
import 'route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: Endpoints.filename);
  setupAllDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
          title: 'Movie Firestore',
          initialRoute: checkAuthRoute,
          routes: routes),
    );
  }
}
