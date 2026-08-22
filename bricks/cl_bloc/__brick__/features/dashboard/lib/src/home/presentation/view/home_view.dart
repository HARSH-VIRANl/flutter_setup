import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../widget/demo_api_card.dart';
import '../widget/language_toggle_button.dart';
import '../widget/stat_card.dart';
import '../widget/tip_card.dart';
import '../widget/welcome_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).home,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
        actions: [
          const LanguageToggleButton(),
          SizedBox(width: 8.w),
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeCard(),
              SizedBox(height: 24.h),
              Text(
                S.of(context).general,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.language_rounded,
                      label: S.of(context).language,
                      value: BlocBuilder<AppSettingsBloc, AppSettingsState>(
                        builder: (context, s) =>
                            Text(s.locale == 'hi' ? S.of(context).hindi : S.of(context).english,
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700)),
                      ),
                      color: const Color(0xFF7349D3),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: StatCard(
                      icon: Icons.brightness_6_rounded,
                      label: S.of(context).appearance,
                      value: BlocBuilder<AppSettingsBloc, AppSettingsState>(
                        builder: (context, s) => Text(
                            s.isDarkMode ? '🌙 ${S.of(context).themeDark}' : '☀️ ${S.of(context).themeLight}',
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              const DemoApiCard(),
              SizedBox(height: 16.h),
              const TipCard(),
            ],
          ),
        ),
      ),
    );
  }
}
