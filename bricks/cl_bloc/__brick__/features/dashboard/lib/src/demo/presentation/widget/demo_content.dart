import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../../bloc/demo_bloc.dart';
import '../../data/model/demo_model.dart';
import 'user_card.dart';

class DemoContent extends StatelessWidget {
  final List<DemoUserModel> users;

  const DemoContent({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DemoBloc>().add(const GetDemoDataEvent());
      },
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Banner
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cloud_done_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Clean Architecture + fpdart',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.greenAccent.withOpacity(0.6)),
                      ),
                      child: Text(
                        'HTTP 200 OK',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'GET https://jsonplaceholder.typicode.com/users',
                  style: GoogleFonts.firaCode(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Flow: Page (Direct DI) → Bloc → UseCase (tryParseList) → Repository → ResponseHandler',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 10.5.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Total Count Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).liveUsersList,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${users.length} ${S.of(context).usersLoaded}',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Users List
          ...users.map((user) => UserCard(user: user)),
        ],
      ),
    );
  }
}
