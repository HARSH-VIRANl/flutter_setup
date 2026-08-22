part of '{{name.snakeCase()}}_bloc.dart';

@immutable
class {{name.pascalCase()}}State extends Equatable {
  final BaseStateStatus status;
  final String? errorMessage;

  const {{name.pascalCase()}}State({
    this.status = BaseStateStatus.initial,
    this.errorMessage,
  });

  {{name.pascalCase()}}State copyWith({
    BaseStateStatus? status,
    String? errorMessage,
  }) {
    return {{name.pascalCase()}}State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
