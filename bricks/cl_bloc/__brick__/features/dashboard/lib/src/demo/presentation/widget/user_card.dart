import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../../data/model/demo_model.dart';

class UserCard extends StatelessWidget {
  final DemoUserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '@${user.username} • ${user.companyName}',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'ID: #${user.id}',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1),
          SizedBox(height: 12.h),

          // Contact details
          Row(
            children: [
              Icon(Icons.email_outlined, size: 16.sp, color: theme.hintColor),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  user.email,
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 16.sp, color: theme.hintColor),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  user.phone,
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.language_rounded, size: 16.sp, color: theme.hintColor),
              SizedBox(width: 4.w),
              Text(
                user.website,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
