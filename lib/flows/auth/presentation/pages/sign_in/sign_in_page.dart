import 'package:shelters/flows/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:shelters/services/helpers/email_validation.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/widgets/app_text_field.dart';
import 'package:shelters/widgets/primary_button.dart';

import '../../../../../navigation/app_state_cubit/app_state_cubit.dart';
import 'cubit/sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => getIt<SignInCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  context.read<AppStateCubit>().checkAuthStatus();
                } else if (state is SignInError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorText)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: context.read<SignInCubit>().formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 210),
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller:
                              context.read<SignInCubit>().emailController,
                          label: 'Email',
                          textColor: Theme.of(context).scaffoldBackgroundColor,
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
                              context.read<SignInCubit>().passwordController,
                          label: 'Password',
                          textColor: Theme.of(context).scaffoldBackgroundColor,
                          obsureText: true,
                          validator: (input) {
                            if (input != null && input.isEmpty) {
                              return 'A password is required';
                            }
                            if (input != null && input.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          title: 'Sign in',
                          color: Theme.of(context).scaffoldBackgroundColor,
                          titleColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            final formState = context
                                .read<SignInCubit>()
                                .formKey
                                .currentState;
                            if (formState?.validate() ?? false) {
                              await context.read<SignInCubit>().signIn();
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Routemaster.of(context).push(SignUpPage.path);
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color(0xffede737),
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
