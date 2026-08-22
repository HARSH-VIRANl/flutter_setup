part of 'app_settings_bloc.dart';

@immutable
class AppSettingsState extends Equatable {
  final bool isDarkMode;
  final String locale;
  final bool isConnected;

  const AppSettingsState({
    required this.isDarkMode,
    required this.locale,
    required this.isConnected,
  });

  @override
  List<Object?> get props => [
        isDarkMode,
        locale,
        isConnected,
      ];
}
