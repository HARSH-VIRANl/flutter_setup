import 'dart:async';

import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.preference}) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(
        NavigateToNextPage(
          isUserLoggedIn:
              await preference.readBool(PreferenceConstants.isUserLoggedInKey),
        ),
      );
    });
  }

  final AppPreference preference;
}
