import 'dart:async';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppPreference preference;

  LoginBloc({required this.preference}) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  FutureOr<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        errorMessage: S.current.mustNotBeEmpty,
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      // Simulate authentication request
      await Future.delayed(const Duration(seconds: 1));

      // Save login state in secure storage
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
