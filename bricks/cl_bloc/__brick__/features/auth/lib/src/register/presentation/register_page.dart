import 'package:auth/src/register/bloc/register_bloc.dart';
import 'package:auth/src/register/presentation/view/register_view.dart';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(preference: GetIt.instance.get<AppPreference>());
  }

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => _registerBloc,
      child: const RegisterView(),
    );
  }
}
