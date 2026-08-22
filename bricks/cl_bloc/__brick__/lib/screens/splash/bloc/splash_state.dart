part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class NavigateToNextPage extends SplashState {
  final bool isUserLoggedIn;
  NavigateToNextPage({required this.isUserLoggedIn});
}
