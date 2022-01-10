part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoding extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RestRegister? restRegister;
  RegisterSuccess(this.restRegister);
}

class RegisterError extends RegisterState {
  final String? message;
  RegisterError(this.message);
}
