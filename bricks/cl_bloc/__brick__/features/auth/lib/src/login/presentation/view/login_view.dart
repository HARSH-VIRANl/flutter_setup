import 'package:auth/src/login/bloc/login_bloc.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.read<AppSettingsBloc>().state.isDarkMode;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == BaseStateStatus.success) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state.status == BaseStateStatus.failure && state.errorMessage != null) {
          AppSnackBar.showErrorSnackBar(context, state.errorMessage!);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo Header
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF7349D3), const Color(0xFF8C73C8)]
                            : [LightThemeColor.primaryColor, LightThemeColor.primaryColorLight],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.lock_outline_rounded, color: Colors.white, size: 36.sp),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    S.of(context).login,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    S.of(context).welcome,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: theme.hintColor,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Email Input
                  Text(
                    S.of(context).emailAddress,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => context.read<LoginBloc>().add(LoginEmailChanged(val)),
                    decoration: InputDecoration(
                      hintText: S.of(context).email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Password Input
                  Text(
                    S.of(context).password,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  TextFormField(
                    obscureText: _obscurePassword,
                    onChanged: (val) => context.read<LoginBloc>().add(LoginPasswordChanged(val)),
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // Submit Button
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final isLoading = state.status == BaseStateStatus.loading;
                      return CommonButton(
                        text: S.of(context).login,
                        isLoading: isLoading,
                        onPressed: () {
                          if (!isLoading) {
                            context.read<LoginBloc>().add(const LoginSubmitted());
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
