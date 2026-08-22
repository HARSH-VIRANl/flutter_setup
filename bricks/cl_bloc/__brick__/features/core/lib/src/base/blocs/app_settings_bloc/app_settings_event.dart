part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();
}

class ThemeChangeEvent extends AppSettingsEvent {
  final bool isDarkMode;

  const ThemeChangeEvent({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}

class LocalizationChangeEvent extends AppSettingsEvent {
  final String locale;

  const LocalizationChangeEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}

class ConnectivityChangeEvent extends AppSettingsEvent {
  final bool isConnected;

  const ConnectivityChangeEvent({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}
