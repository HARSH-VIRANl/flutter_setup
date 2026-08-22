import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../bloc/demo_bloc.dart';
import '../data/repositories/demo_repository_impl.dart';
import '../domain/usecases/demo_usecase.dart';
import 'view/demo_view.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final demoRepository = DemoRepositoryImpl(
      dio: GetIt.instance.get<BaseApiProvider>(),
    );

    return BlocProvider(
      create: (context) => DemoBloc(
        demoUsecase: DemoUsecase(
          demoRepository: demoRepository,
        ),
      )..add(const GetDemoDataEvent()),
      child: DemoView(demoRepository: demoRepository),
    );
  }
}
