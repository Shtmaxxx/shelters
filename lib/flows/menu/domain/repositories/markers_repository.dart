import 'package:dartz/dartz.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/menu/domain/entities/marker_point.dart';
import 'package:shelters/flows/menu/domain/usecases/add_marker_point.dart';
import 'package:shelters/flows/menu/domain/usecases/remove_marker_point.dart';

abstract class MarkersRepositoryI {
  Future<Either<Failure, List<MarkerPoint>>> getMarkers(String userId);
  Future<Either<Failure, void>> addMarkerPoint(AddMarkerPointParameters parameters);
  Future<Either<Failure, void>> removeMarkerPoint(RemoveMarkerPointParameters parameters);
}
