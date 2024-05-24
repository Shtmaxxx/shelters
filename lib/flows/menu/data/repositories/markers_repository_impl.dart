import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/menu/data/datasources/markers_datasource.dart';
import 'package:shelters/flows/menu/domain/entities/marker_point.dart';
import 'package:shelters/flows/menu/domain/repositories/markers_repository.dart';

@Injectable(as: MarkersRepositoryI)
class MarkersRepositoryImpl implements MarkersRepositoryI {
  final MarkersDatasourceI remoteDataSource;

  MarkersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MarkerPoint>>> getMarkers(String userId) async {
    try {
      final result = await remoteDataSource.getMarkers(userId);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }
}
