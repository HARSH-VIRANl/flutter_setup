import 'dart:async';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(ForgotPasswordEmailChanged event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  FutureOr<void> _onSubmitted(ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    if (state.email.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.mustNotBeEmpty,
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      // Simulate password reset request
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        status: BaseStateStatus.success,
        isEmailSent: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.somethingWentWrong,
      ));
    }
  }
}
