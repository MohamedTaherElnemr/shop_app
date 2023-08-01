part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserData RegisterDate;

  RegisterSuccess(this.RegisterDate);
}

class RegisterFailed extends RegisterState {
  final String errMessage;

  RegisterFailed(this.errMessage);
}
