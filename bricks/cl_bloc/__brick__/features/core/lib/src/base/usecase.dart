import 'package:core/core_exports.dart';

abstract class UseCase<TypeResult, Params> {
  Future<Either<Failure, TypeResult>> call(Params params);
}

class NoParamModelForUseCase extends Equatable {
  const NoParamModelForUseCase();

  @override
  List<Object?> get props => [];
}
