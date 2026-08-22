import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object> get props => [message];
}

//define general failures here

//server side exception failure
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

// try catch exception failure
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
