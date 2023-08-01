part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserData loginDate;

  LoginSuccess(this.loginDate);
}

class LoginFailed extends LoginState {
  final String errMessage;

  LoginFailed(this.errMessage);
}
