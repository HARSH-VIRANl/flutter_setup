import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          final isDark = state.isDarkMode;
          final isHindi = state.locale == 'hi';

          return Column(
            children: [
              // Drawer Header
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                        : [
                            LightThemeColor.primaryColor,
                            LightThemeColor.primaryColorLight,
                          ],
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_rounded,
                    size: 40.sp,
                    color: isDark
                        ? const Color(0xFF7349D3)
                        : LightThemeColor.primaryColor,
                  ),
                ),
                accountName: Text(
                  S.of(context).appName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  S.of(context).welcomeMessage,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),

              // Drawer Navigation Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home_rounded),
                      title: Text(
                        S.of(context).home,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (ModalRoute.of(context)?.settings.name != AppRoutes.home) {
                          Navigator.pushReplacementNamed(context, AppRoutes.home);
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings_rounded),
                      title: Text(
                        S.of(context).settings,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (ModalRoute.of(context)?.settings.name != AppRoutes.settings) {
                          Navigator.pushReplacementNamed(context, AppRoutes.settings);
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics_rounded),
                      title: Text(
                        'Demo API Dashboard',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'fpdart + Clean Architecture',
                        style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (ModalRoute.of(context)?.settings.name != AppRoutes.demo) {
                          Navigator.pushNamed(context, AppRoutes.demo);
                        }
                      },
                    ),
                    const Divider(),
                    // Dark Mode Toggle
                    SwitchListTile.adaptive(
                      secondary: Icon(
                        isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      ),
                      title: Text(
                        S.of(context).darkMode,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      value: isDark,
                      activeTrackColor: theme.colorScheme.primary,
                      onChanged: (val) {
                        context
                            .read<AppSettingsBloc>()
                            .add(ThemeChangeEvent(isDarkMode: val));
                      },
                    ),
                    // Language Switch (English <-> Hindi)
                    ListTile(
                      leading: const Icon(Icons.language_rounded),
                      title: Text(
                        S.of(context).language,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          isHindi ? 'हिंदी' : 'English',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      onTap: () {
                        context.read<AppSettingsBloc>().add(
                              LocalizationChangeEvent(
                                locale: isHindi ? 'en' : 'hi',
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),

              const Divider(),
              // Logout Button
              ListTile(
                leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                title: Text(
                  S.of(context).logout,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final pref = GetIt.instance.get<AppPreference>();
                  await pref.writeBool(PreferenceConstants.isUserLoggedInKey, false);
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  }
                },
              ),
              SizedBox(height: 12.h),
            ],
          );
        },
      ),
    );
  }
}
