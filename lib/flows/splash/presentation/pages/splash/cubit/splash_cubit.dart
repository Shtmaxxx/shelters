import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashPageState> {
  SplashCubit() : super(SplashLoading());

  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(ShowAuth());
  }
}
