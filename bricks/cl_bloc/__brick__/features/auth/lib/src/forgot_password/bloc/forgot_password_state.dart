part of 'forgot_password_bloc.dart';

@immutable
class ForgotPasswordState extends Equatable {
  final String email;
  final BaseStateStatus status;
  final String? errorMessage;
  final bool isEmailSent;

  const ForgotPasswordState({
    this.email = '',
    this.status = BaseStateStatus.initial,
    this.errorMessage,
    this.isEmailSent = false,
  });

  ForgotPasswordState copyWith({
    String? email,
    BaseStateStatus? status,
    String? errorMessage,
    bool? isEmailSent,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isEmailSent: isEmailSent ?? this.isEmailSent,
    );
  }

  @override
  List<Object?> get props => [email, status, errorMessage, isEmailSent];
}
