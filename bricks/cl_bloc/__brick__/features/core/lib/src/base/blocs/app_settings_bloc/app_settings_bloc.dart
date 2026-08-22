import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/src/api/local/shared_preference/app_preference.dart';
import 'package:core/src/api/local/shared_preference/preference_constants.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc(super.initialState) {
    on<ThemeChangeEvent>(_onThemeChange);
    on<LocalizationChangeEvent>(_onLocalizationChange);
    on<ConnectivityChangeEvent>(_onConnectivityChange);
  }

  final AppPreference _pref =
      GetIt.instance.get<AppPreference>();

  FutureOr<void> _onThemeChange(
    ThemeChangeEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(AppSettingsState(
      isDarkMode: event.isDarkMode,
      locale: state.locale,
      isConnected: state.isConnected,
    ));
    // Persist the choice so it survives app restart
    await _pref.writeBool(PreferenceConstants.isDarkModeKey, event.isDarkMode);
  }

  FutureOr<void> _onLocalizationChange(
    LocalizationChangeEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(AppSettingsState(
      isDarkMode: state.isDarkMode,
      locale: event.locale,
      isConnected: state.isConnected,
    ));
    // Persist the chosen locale
    await _pref.writeString(PreferenceConstants.localeKey, event.locale);
  }

  FutureOr<void> _onConnectivityChange(
    ConnectivityChangeEvent event,
    Emitter<AppSettingsState> emit,
  ) {
    emit(AppSettingsState(
      isDarkMode: state.isDarkMode,
      locale: state.locale,
      isConnected: event.isConnected,
    ));
  }
}
