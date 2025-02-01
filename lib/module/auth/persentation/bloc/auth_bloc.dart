import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/login_usecase.dart';
import '../../domain/use_case/register_usecase.dart';
import 'auth_state.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;

  AuthBloc(this.registerUsecase, this.loginUsecase) : super(RegisterInitial()) {
    on<ProcessRegister>(_onProcessRegister);
    on<ProcessLogin>(_onProcessLogin);
  }

  Future<void> _onProcessRegister(
      ProcessRegister event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    try {
      final userCredential = await registerUsecase(event.email, event.password);
      emit(RegisterSuccess(userCredential));
    } on FirebaseAuthException catch (e) {
      emit(RegisterError('${e.message}'));
    }
  }

  Future<void> _onProcessLogin(
      ProcessLogin event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    try {
      final user = await loginUsecase(event.email, event.password);
      emit(LoginSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(LoginError('${e.message}'));
    }
  }
}
