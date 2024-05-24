import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [message];

  final String message;
  final String? fieldError;
  final String? field;

  const Failure({
    required this.message,
    this.field,
    this.fieldError,
  });
}

// General failures
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    super.fieldError,
    super.field,
    this.statusCode,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.fieldError,
    super.field,
  });
}

class CardFailure extends Failure {
  const CardFailure({
    required super.message,
    super.fieldError,
    super.field,
  });
}

class OtherFailure extends Failure {
  const OtherFailure({
    required super.message,
    super.fieldError,
    super.field,
  });
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = 'There is no Internet connection',
    super.fieldError,
    super.field,
  });
}
