part of 'splash_cubit.dart';

abstract class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashPageState {}

class ShowOnboarding extends SplashPageState {}

class ShowAuth extends SplashPageState {}
