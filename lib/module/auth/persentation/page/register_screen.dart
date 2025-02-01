import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

import '../../../../component/reusable/reusable.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullname.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void handleRegister() {
    FocusScope.of(context).unfocus();
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      if (_password.text == _confirmPassword.text) {
        context
            .read<AuthBloc>()
            .add(ProcessRegister(_email.text, _password.text));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "REGISTER",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Fullname"),
            textField('ex: john doe', _fullname, false),
            SizedBox(
              height: 8,
            ),
            Text("Email"),
            textField('ex: john@gmail.com', _email, false),
            SizedBox(
              height: 8,
            ),
            Text("Password"),
            textField(null, _password, true),
            SizedBox(
              height: 8,
            ),
            Text("Confirm Password"),
            textField(null, _confirmPassword, true),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                  if (state is RegisterError) {
                    log('gagal error ${state.message}');
                  } else if (state is RegisterSuccess) {
                    _email.clear();
                    _password.clear();
                    _confirmPassword.clear();
                    _fullname.clear();
                    log('success ${state.userCredential.user?.email}');
                    setState(() {});
                  }
                }, builder: (context, state) {
                  if (state is RegisterLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                      onPressed: handleRegister, child: Text("Register"));
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
