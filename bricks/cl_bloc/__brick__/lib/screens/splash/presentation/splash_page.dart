import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/screens/splash/bloc/splash_bloc.dart';
import 'package:{{{fullPath}}}/screens/splash/presentation/view/splash_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashBloc splashBloc;

  @override
  void initState() {
    super.initState();
    splashBloc = SplashBloc(preference: GetIt.instance.get<AppPreference>())
      ..add(SplashEvent());
  }

  @override
  void dispose() {
    splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: splashBloc,
      listenWhen: (previous, current) => current is NavigateToNextPage,
      builder: (context, state) => const SplashView(),
      listener: (context, state) async {
        if (state is NavigateToNextPage) {
          if (state.isUserLoggedIn) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        }
      },
    );
  }
}
