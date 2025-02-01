import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository registerRepository;
  LoginUsecase(this.registerRepository);

  Future<UserCredential> call(String email, String password) {
    return registerRepository.login(email, password);
  }
}
