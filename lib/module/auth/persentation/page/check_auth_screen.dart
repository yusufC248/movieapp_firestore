import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../component/nav/navigasi.dart';
import '../../../../core/injection/di.dart';
import 'auth_screen.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: getIt<FirebaseAuth>().authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigasi();
            } else {
              return AuthScreen();
            }
          }),
    );
  }
}
