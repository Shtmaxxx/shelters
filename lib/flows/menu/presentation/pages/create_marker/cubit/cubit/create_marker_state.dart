part of 'create_marker_cubit.dart';

abstract class CreateMarkerState extends Equatable {
  const CreateMarkerState();

  @override
  List<Object> get props => [];
}

class CreateMarkerInitial extends CreateMarkerState {}

class CreateMarkerError extends CreateMarkerState {
  const CreateMarkerError({
    required this.failure,
  });

  final Failure failure;
}

