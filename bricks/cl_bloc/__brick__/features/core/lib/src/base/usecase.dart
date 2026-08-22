import 'package:core/core_exports.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParamModelForUseCase extends Equatable {
  const NoParamModelForUseCase();

  @override
  List<Object?> get props => [];
}
