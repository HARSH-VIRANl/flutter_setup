import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final bool isConnected;

  const NoInternetWidget({
    super.key,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: Material(
        type: MaterialType.transparency,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
          color: Colors.red.shade700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                S.of(context).noInternetConnection,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      crossFadeState:
          isConnected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}
