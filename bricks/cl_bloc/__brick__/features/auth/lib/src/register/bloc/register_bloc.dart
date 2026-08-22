import 'dart:async';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AppPreference preference;

  RegisterBloc({required this.preference}) : super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name, errorMessage: null));
  }

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onConfirmPasswordChanged(RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, errorMessage: null));
  }

  FutureOr<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty || state.confirmPassword.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.mustNotBeEmpty,
      ));
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.passwordNotMatched,
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      // Simulate registration network call
      await Future.delayed(const Duration(seconds: 1));

      // Save logged in state
      await preference.writeBool(PreferenceConstants.isUserLoggedInKey, true);

      emit(state.copyWith(status: BaseStateStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.somethingWentWrong,
      ));
    }
  }
}
