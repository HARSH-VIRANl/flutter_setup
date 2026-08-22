import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../../bloc/demo_bloc.dart';
import '../../data/repositories/demo_repository_impl.dart';
import '../widget/demo_content.dart';

class DemoView extends StatelessWidget {
  final DemoRepository demoRepository;

  const DemoView({super.key, required this.demoRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).demoCleanArchitecture,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: S.of(context).reloadApi,
            onPressed: () {
              context.read<DemoBloc>().add(const GetDemoDataEvent());
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DemoBloc, DemoState>(
          builder: (context, state) {
            return BaseStateWidget(
              status: state.status,
              errorMessage: state.errorMessage,
              loadingMessage: S.of(context).fetchingUsers,
              onRetry: () {
                context.read<DemoBloc>().add(const GetDemoDataEvent());
              },
              onSuccess: () {
                final data = state.demoData;
                if (data == null || data.users.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noUsersFound,
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  );
                }
                return DemoContent(data: data);
              },
            );
          },
        ),
      ),
    );
  }
}
