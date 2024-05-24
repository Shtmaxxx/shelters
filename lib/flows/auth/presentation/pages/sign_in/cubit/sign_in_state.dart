part of 'sign_in_cubit.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String errorText;

  const SignInError(this.errorText);
}
