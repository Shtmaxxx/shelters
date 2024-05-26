import 'package:shelters/flows/menu/domain/entities/marker_point.dart';

class MarkerPointModel extends MarkerPoint {
  MarkerPointModel({
    required super.id,
    required super.name,
    required super.description,
    required super.chatId,
    required super.shelterJoined,
    required super.latitude,
    required super.longitude,
  });
}