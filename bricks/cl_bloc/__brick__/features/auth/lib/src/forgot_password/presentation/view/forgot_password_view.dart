import 'package:auth/src/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.read<AppSettingsBloc>().state.isDarkMode;

    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == BaseStateStatus.failure && state.errorMessage != null) {
          AppSnackBar.showErrorSnackBar(context, state.errorMessage!);
        } else if (state.isEmailSent) {
          AppSnackBar.showSuccessSnackBar(context, 'Reset link sent successfully!');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo Header
                    Center(
                      child: Container(
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
                        child: Icon(Icons.lock_reset_rounded, color: Colors.white, size: 36.sp),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      S.of(context).forgotPassword,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      S.of(context).resetPasswordDescription,
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
                      onChanged: (val) => context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailChanged(val)),
                      decoration: InputDecoration(
                        hintText: S.of(context).email,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Submit Button
                    CommonButton(
                      text: S.of(context).sendResetLink,
                      isLoading: state.status == BaseStateStatus.loading,
                      onPressed: () {
                        if (state.status != BaseStateStatus.loading) {
                          context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitted());
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          S.of(context).backToLogin,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
