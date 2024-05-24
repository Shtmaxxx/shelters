import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/sign_up.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpUseCase) : super(SignUpInitial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final SignUpUseCase signUpUseCase;

  Future<void> signUp() async {
    final result = await signUpUseCase(
      SignUpParams(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    result.fold(
      (failure) {
        emit(SignUpError(failure.message));
      },
      (result) {
        emit(SignUpSuccess());
      },
    );
  }
}
