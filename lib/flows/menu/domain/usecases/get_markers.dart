import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/menu/domain/entities/marker_point.dart';
import 'package:shelters/flows/menu/domain/repositories/markers_repository.dart';

@injectable
class GetMarkersUseCase implements UseCase<List<MarkerPoint>, String> {
  final MarkersRepositoryI repository;

  GetMarkersUseCase(this.repository);

  @override
  Future<Either<Failure, List<MarkerPoint>>> call(String userId) async {
    return await repository.getMarkers(userId);
  }
}