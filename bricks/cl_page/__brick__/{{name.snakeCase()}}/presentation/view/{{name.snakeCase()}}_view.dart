import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../../bloc/{{name.snakeCase()}}_bloc.dart';

class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '{{name.titleCase()}}',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
          builder: (context, state) {
            return BaseStateWidget(
              status: state.status,
              onSuccess: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 64.sp,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '{{name.titleCase()}} Content',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
