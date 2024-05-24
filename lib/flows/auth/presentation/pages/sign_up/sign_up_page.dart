import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/auth/presentation/widgets/auth_button.dart';
import 'package:shelters/services/helpers/email_validation.dart';
import 'package:shelters/widgets/app_text_field.dart';

import '../../../../../navigation/app_state_cubit/app_state_cubit.dart';
import '../../../../../services/injectible/injectible_init.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const path = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => getIt<SignUpCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  context.read<AppStateCubit>().checkAuthStatus();
                } else if (state is SignUpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorText)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: context.read<SignUpCubit>().formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 210),
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: AppTextField(
                            controller:
                                context.read<SignUpCubit>().nameController,
                            label: 'Name',
                            validator: (input) {
                              if (input != null && input.isEmpty) {
                                return 'Name is required';
                              }
                              if (input != null && input.length < 4) {
                                return 'Name must be at least 4 characters';
                              }
                              if (input != null && input.length > 30) {
                                return 'Name is too long';
                              }
                              return null;
                            },
                          ),
                        ),
                        AppTextField(
                          controller:
                              context.read<SignUpCubit>().emailController,
                          label: 'Email',
                          validator: (input) {
                            if (input != null) {
                              return input.isValidEmail()
                                  ? null
                                  : 'A valid email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller:
                              context.read<SignUpCubit>().passwordController,
                          label: 'Password',
                          obsureText: true,
                          validator: (input) {
                            if (input != null && input.isEmpty) {
                              return 'Password is required';
                            }
                            if (input != null && input.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          name: 'Sign up',
                          onPressed: () async {
                            final formState = context
                                .read<SignUpCubit>()
                                .formKey
                                .currentState;
                            if (formState?.validate() ?? false) {
                              await context.read<SignUpCubit>().signUp();
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'Do you have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Routemaster.of(context).pop();
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color(0xFFFFE500),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
