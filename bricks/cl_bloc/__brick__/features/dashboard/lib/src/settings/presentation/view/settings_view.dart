import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../widget/language_option_tile.dart';
import '../widget/settings_card.dart';
import '../widget/settings_section_header.dart';
import '../widget/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final isDark = state.isDarkMode;
        final isHindi = state.locale == 'hi';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).settingsTitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.onSurface,
              ),
            ),
            centerTitle: false,
          ),
          drawer: const AppDrawer(),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                SettingsSectionHeader(title: S.of(context).appearance),
                SizedBox(height: 8.h),
                SettingsCard(
                  children: [
                    SettingsTile(
                       icon: isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      iconColor: isDark
                          ? const Color(0xFF9575CD)
                          : const Color(0xFFFFA726),
                      title: S.of(context).darkMode,
                      subtitle: isDark
                          ? '🌙 ${S.of(context).darkThemeActive}'
                          : '☀️ ${S.of(context).lightThemeActive}',
                      trailing: Switch.adaptive(
                        value: isDark,
                        onChanged: (val) => context
                            .read<AppSettingsBloc>()
                            .add(ThemeChangeEvent(isDarkMode: val)),
                        activeTrackColor: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SettingsSectionHeader(title: S.of(context).language),
                SizedBox(height: 8.h),
                SettingsCard(
                  children: [
                    LanguageOptionTile(
                      flag: '🇬🇧',
                      language: S.of(context).english,
                      code: 'en',
                      isSelected: !isHindi,
                    ),
                    Divider(height: 1, indent: 56.w),
                    LanguageOptionTile(
                      flag: '🇮🇳',
                      language: S.of(context).hindi,
                      code: 'hi',
                      isSelected: isHindi,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SettingsSectionHeader(title: S.of(context).general),
                SizedBox(height: 8.h),
                SettingsCard(
                  children: [
                    SettingsTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: const Color(0xFF42A5F5),
                      title: S.of(context).version,
                      subtitle: '1.0.0 (Build 1)',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
