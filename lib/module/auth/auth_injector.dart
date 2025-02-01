import 'package:firebase_auth/firebase_auth.dart';

import '../../core/injection/di.dart';
import 'data/repository/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_case/login_usecase.dart';
import 'domain/use_case/register_usecase.dart';
import 'persentation/bloc/auth_bloc.dart';

Future<void> setupAuth() async {
  final authInit = FirebaseAuth.instance;

  getIt
    ..registerLazySingleton<FirebaseAuth>(() => authInit)
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt<FirebaseAuth>()))
    ..registerLazySingleton<RegisterUsecase>(
        () => RegisterUsecase(getIt<AuthRepository>()))
    ..registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(getIt<AuthRepository>()))
    ..registerFactory<AuthBloc>(
        () => AuthBloc(getIt<RegisterUsecase>(), getIt<LoginUsecase>()));
}
