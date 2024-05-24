part of 'sign_up_cubit.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String errorText;

  const SignUpError(this.errorText);
}
