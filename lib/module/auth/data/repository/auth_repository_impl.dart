import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<UserCredential> register(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }
}
