import 'package:core/core_exports.dart';
import 'package:dashboard/src/home/bloc/home_bloc.dart';
import 'package:dashboard/src/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc()..add(const HomeStarted());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => _homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return const HomeView();
        },
      ),
    );
  }
}
