import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:routemaster/routemaster.dart';

import '../../domain/auth/repository/auth_repo.dart';
import '../app_map.dart';
import '../auth_map.dart';
import '../splash_map.dart';

part '../app_state_cubit/app_state.dart';

@injectable
class AppStateCubit extends Cubit<AppState> {
  final AuthRepositoryI authRepository;
  final FirebaseAuth firebaseAuth;

  AppStateCubit({
    required this.authRepository,
    required this.firebaseAuth,
  }) : super(SplashState());

  void checkAuthStatus() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      final result =
          await authRepository.isUserSignedIn(currentUser.email ?? '');
      result.fold(
        (failure) {
          emit(UnauthorizedState());
        },
        (user) {
          emit(AuthorizedState(user: user));
        },
      );
    } else {
      emit(UnauthorizedState());
    }
  }

  void logOut() async {
    await firebaseAuth.signOut();
    checkAuthStatus();
  }
}
