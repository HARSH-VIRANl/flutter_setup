import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class LanguageOptionTile extends StatelessWidget {
  final String flag;
  final String language;
  final String code;
  final bool isSelected;

  const LanguageOptionTile({
    super.key,
    required this.flag,
    required this.language,
    required this.code,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => context
          .read<AppSettingsBloc>()
          .add(LocalizationChangeEvent(locale: code)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24.sp)),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                language,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.hintColor.withValues(alpha: 0.4),
                  width: 2,
                ),
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded,
                      color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
