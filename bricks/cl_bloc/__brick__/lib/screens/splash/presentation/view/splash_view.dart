import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            child: ColoredBox(color: context.theme.scaffoldBackgroundColor),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 44.w,
            right: 44.w,
            child: const FlutterLogo(
              size: 58,
            ),
          ),
        ],
      ),
    );
  }
}
