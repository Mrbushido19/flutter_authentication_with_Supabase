part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUp(this.name, this.email, this.password);
}

final class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  AuthLogIn(this.email, this.password);
}
