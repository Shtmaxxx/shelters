import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelters/flows/auth/domain/usecases/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInUseCase) : super(SignInInitial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final SignInUseCase signInUseCase;

  Future<void> signIn() async {
    final result = await signInUseCase(
      SignInParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    result.fold(
      (failure) {
        emit(SignInError(failure.message));
      },
      (result) {
        emit(SignInSuccess());
      },
    );
  }
}
