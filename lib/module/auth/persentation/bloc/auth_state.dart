import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class RegisterInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final UserCredential userCredential;
  RegisterSuccess(this.userCredential);
}

class LoginSuccess extends AuthState {
  final UserCredential userCredential;
  LoginSuccess(this.userCredential);
}

class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}
