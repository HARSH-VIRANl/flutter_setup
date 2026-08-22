import 'package:auth/src/login/bloc/login_bloc.dart';
import 'package:auth/src/login/presentation/view/login_view.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(preference: GetIt.instance.get<AppPreference>());
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => _loginBloc,
      child: const LoginView(),
    );
  }
}
