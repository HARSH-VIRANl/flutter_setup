import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates_rounded,
              color: theme.colorScheme.primary, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              S.of(context).drawerTip,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
