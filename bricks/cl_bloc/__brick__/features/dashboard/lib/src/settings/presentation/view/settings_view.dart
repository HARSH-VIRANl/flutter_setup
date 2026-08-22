import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

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
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
          ),
          drawer: const AppDrawer(),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _SettingsSectionHeader(title: S.of(context).appearance),
                SizedBox(height: 8.h),
                _SettingsCard(
                  children: [
                    _SettingsTile(
                      icon: isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      iconColor: isDark
                          ? const Color(0xFF9575CD)
                          : const Color(0xFFFFA726),
                      title: S.of(context).darkMode,
                      subtitle: isDark ? '🌙 Dark theme active' : '☀️ Light theme active',
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
                _SettingsSectionHeader(title: S.of(context).language),
                SizedBox(height: 8.h),
                _SettingsCard(
                  children: [
                    _LanguageOptionTile(
                      flag: '🇬🇧',
                      language: S.of(context).english,
                      code: 'en',
                      isSelected: !isHindi,
                    ),
                    Divider(height: 1, indent: 56.w),
                    _LanguageOptionTile(
                      flag: '🇮🇳',
                      language: S.of(context).hindi,
                      code: 'hi',
                      isSelected: isHindi,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _SettingsSectionHeader(title: S.of(context).general),
                SizedBox(height: 8.h),
                _SettingsCard(
                  children: [
                    _SettingsTile(
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

class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: iconColor, size: 22.sp),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: theme.hintColor,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final String flag;
  final String language;
  final String code;
  final bool isSelected;

  const _LanguageOptionTile({
    required this.flag,
    required this.language,
    required this.code,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => context
          .read<AppSettingsBloc>()
          .add(LocalizationChangeEvent(locale: code)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24.sp)),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                language,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.hintColor.withValues(alpha: 0.4),
                  width: 2,
                ),
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded,
                      color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
