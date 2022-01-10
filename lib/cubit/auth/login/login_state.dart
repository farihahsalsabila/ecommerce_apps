part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final RestLogin? restLogin;
  LoginSuccess(this.restLogin);
}

class LoginError extends LoginState {
  final String? message;
  LoginError(this.message);
}
