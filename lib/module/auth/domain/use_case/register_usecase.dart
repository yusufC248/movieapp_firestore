import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository registerRepository;
  RegisterUsecase(this.registerRepository);

  Future<UserCredential> call(String email, String password) {
    return registerRepository.register(email, password);
  }
}
