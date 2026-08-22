import 'dart:async';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}Started>(_onStarted);
  }

  FutureOr<void> _onStarted(
    {{name.pascalCase()}}Started event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(status: BaseStateStatus.success));
  }
}
