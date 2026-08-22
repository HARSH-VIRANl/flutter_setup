part of 'demo_bloc.dart';

class DemoState extends Equatable {
  final BaseStateStatus status;
  final String? errorMessage;
  final DemoModel? demoData;

  const DemoState({
    this.status = BaseStateStatus.initial,
    this.errorMessage,
    this.demoData,
  });

  DemoState copyWith({
    BaseStateStatus? status,
    String? errorMessage,
    DemoModel? demoData,
  }) {
    return DemoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      demoData: demoData ?? this.demoData,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, demoData];
}
