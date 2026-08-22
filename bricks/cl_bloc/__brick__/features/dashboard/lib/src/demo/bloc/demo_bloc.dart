import 'dart:async';
import 'package:core/core_exports.dart';
import '../data/model/demo_model.dart';
import '../domain/usecases/demo_usecase.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  final DemoUsecase demoUsecase;

  DemoBloc({required this.demoUsecase}) : super(const DemoState()) {
    on<GetDemoDataEvent>(_getDemoDataEvent);
  }

  FutureOr<void> _getDemoDataEvent(
    GetDemoDataEvent event,
    Emitter<DemoState> emit,
  ) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    final response = await demoUsecase.call(
      const NoParamModelForUseCase(),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (demoData) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            demoData: demoData,
          ),
        );
      },
    );
  }
}
