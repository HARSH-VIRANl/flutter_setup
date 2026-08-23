part of 'demo_bloc.dart';

class DemoState extends Equatable {
  final BaseStateStatus status;
  final String? errorMessage;
  final List<DemoUserModel> users;

  const DemoState({
    this.status = BaseStateStatus.initial,
    this.errorMessage,
    this.users = const [],
  });

  DemoState copyWith({
    BaseStateStatus? status,
    String? errorMessage,
    List<DemoUserModel>? users,
  }) {
    return DemoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, users];
}

