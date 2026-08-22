import 'dart:async';
import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onStarted);
  }

  FutureOr<void> _onStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(HomeLoaded());
  }
}
