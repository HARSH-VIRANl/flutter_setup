import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Server side exception failure
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// Cache exception failure
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

// Network exception failure
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No Internet Connection'});
}

// API error response failure
class ApiFailure extends Failure {
  const ApiFailure({required super.message});
}

/// Helper function to create Failure from API response message
Failure getFailureFromAPI(String message) {
  return ApiFailure(
    message: message.isNotEmpty ? message : 'An unexpected error occurred',
  );
}

/// Helper function to create Failure from Exception
Failure getFailureFromException(dynamic exception) {
  if (exception is Failure) {
    return exception;
  }
  return ServerFailure(message: exception.toString());
}
