import 'package:auth/src/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:auth/src/forgot_password/presentation/view/forgot_password_view.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = ForgotPasswordBloc();
  }

  @override
  void dispose() {
    _forgotPasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (_) => _forgotPasswordBloc,
      child: const ForgotPasswordView(),
    );
  }
}
