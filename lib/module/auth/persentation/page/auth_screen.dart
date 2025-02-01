import 'package:flutter/material.dart';
import '../../../../component/reusable/reusable.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: isLogin ? LoginScreen() : RegisterScreen(),
      floatingActionButton: TextButton(
          onPressed: () {
            isLogin = !isLogin;
            setState(() {});
          },
          child:
              Text(isLogin ? "Don't have account? Register" : "Back to login")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
