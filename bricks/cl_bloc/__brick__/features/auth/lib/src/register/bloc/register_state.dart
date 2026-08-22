part of 'register_bloc.dart';

@immutable
class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final BaseStateStatus status;
  final String? errorMessage;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = BaseStateStatus.initial,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    BaseStateStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [name, email, password, confirmPassword, status, errorMessage];
}
