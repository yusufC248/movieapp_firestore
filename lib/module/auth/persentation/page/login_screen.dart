import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../../../../route/route_name.dart';

import '../../../../component/reusable/reusable.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void handleRegister() {
    FocusScope.of(context).unfocus();
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      context.read<AuthBloc>().add(ProcessLogin(_email.text, _password.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text("Email"),
            textField('ex: john@gmail.com', _email, false),
            SizedBox(
              height: 10,
            ),
            Text("Password"),
            textField(null, _password, true),
            SizedBox(
              height: 12,
            ),
            Align(
                alignment: Alignment.center,
                child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                  if (state is LoginError) {
                    log('gagal error ${state.message}');
                  } else if (state is LoginSuccess) {
                    _email.clear();
                    _password.clear();
                    log('success ${state.userCredential.user?.email}');
                    setState(() {});
                    Navigator.pushNamed(context, checkAuthRoute);
                  }
                }, builder: (context, state) {
                  if (state is RegisterLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                      onPressed: handleRegister, child: Text("Login"));
                }))
          ],
        ),
      ),
    );
  }

  Widget textField(String? label, TextEditingController cont, bool isHide) {
    return TextField(
      decoration:
          InputDecoration(hintText: label, border: OutlineInputBorder()),
      obscureText: isHide,
      controller: cont,
    );
  }
}
