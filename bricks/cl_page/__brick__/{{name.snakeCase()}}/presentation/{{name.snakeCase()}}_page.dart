import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../bloc/{{name.snakeCase()}}_bloc.dart';
import 'view/{{name.snakeCase()}}_view.dart';

class {{name.pascalCase()}}Page extends StatefulWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}

class _{{name.pascalCase()}}PageState extends State<{{name.pascalCase()}}Page> {
  late final {{name.pascalCase()}}Bloc _{{name.camelCase()}}Bloc;

  @override
  void initState() {
    super.initState();
    _{{name.camelCase()}}Bloc = {{name.pascalCase()}}Bloc()..add(const {{name.pascalCase()}}Started());
  }

  @override
  void dispose() {
    _{{name.camelCase()}}Bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<{{name.pascalCase()}}Bloc>(
      create: (_) => _{{name.camelCase()}}Bloc,
      child: const {{name.pascalCase()}}View(),
    );
  }
}
