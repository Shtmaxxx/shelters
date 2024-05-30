import 'package:dartz/dartz.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/menu/domain/repositories/markers_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveMarkerPointUseCase implements UseCase<void, RemoveMarkerPointParameters> {
  final MarkersRepositoryI repository;

  RemoveMarkerPointUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveMarkerPointParameters params) async {
    return await repository.removeMarkerPoint(params);
  }
}

class RemoveMarkerPointParameters {
  const RemoveMarkerPointParameters({
    required this.markerId,
    required this.chatId,
  });

  final String markerId;
  final String chatId;
}
