abstract class AuthEvent {}

class ProcessRegister extends AuthEvent {
  final String email;
  final String password;

  ProcessRegister(this.email, this.password);
}

class ProcessLogin extends AuthEvent {
  final String email;
  final String password;

  ProcessLogin(this.email, this.password);
}
