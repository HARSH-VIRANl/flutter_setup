import 'package:auth/src/register/bloc/register_bloc.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.read<AppSettingsBloc>().state.isDarkMode;

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status == BaseStateStatus.success) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state.status == BaseStateStatus.failure && state.errorMessage != null) {
          AppSnackBar.showErrorSnackBar(context, state.errorMessage!);
        }
      },
      child: Scaffold(
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
                      child: Icon(Icons.person_add_outlined, color: Colors.white, size: 36.sp),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    S.of(context).createAccount,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    S.of(context).createAccountSubtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: theme.hintColor,
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // Full Name Input
                  Text(
                    S.of(context).firstName,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (val) => context.read<RegisterBloc>().add(RegisterNameChanged(val)),
                    decoration: InputDecoration(
                      hintText: S.of(context).firstName,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  SizedBox(height: 16.h),

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
                    onChanged: (val) => context.read<RegisterBloc>().add(RegisterEmailChanged(val)),
                    decoration: InputDecoration(
                      hintText: S.of(context).email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(height: 16.h),

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
                    onChanged: (val) => context.read<RegisterBloc>().add(RegisterPasswordChanged(val)),
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
                  SizedBox(height: 16.h),

                  // Confirm Password Input
                  Text(
                    S.of(context).confirmPassword,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  TextFormField(
                    obscureText: _obscureConfirmPassword,
                    onChanged: (val) => context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(val)),
                    decoration: InputDecoration(
                      hintText: S.of(context).confirmPassword,
                      prefixIcon: const Icon(Icons.lock_reset_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // Submit Button
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      final isLoading = state.status == BaseStateStatus.loading;
                      return CommonButton(
                        text: S.of(context).register,
                        isLoading: isLoading,
                        onPressed: () {
                          if (!isLoading) {
                            context.read<RegisterBloc>().add(const RegisterSubmitted());
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Already have an account -> Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).alreadyHaveAccount,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: theme.hintColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          S.of(context).login,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
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
