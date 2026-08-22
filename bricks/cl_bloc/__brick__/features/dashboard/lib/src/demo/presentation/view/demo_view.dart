import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import '../../bloc/demo_bloc.dart';
import '../../data/model/demo_model.dart';
import '../../data/repositories/demo_repository_impl.dart';

class DemoView extends StatelessWidget {
  final DemoRepository demoRepository;

  const DemoView({super.key, required this.demoRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demo Clean Architecture',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload API',
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
              loadingMessage: 'Fetching real-time users from jsonplaceholder.typicode.com...',
              onRetry: () {
                context.read<DemoBloc>().add(const GetDemoDataEvent());
              },
              onSuccess: () {
                final data = state.demoData;
                if (data == null || data.users.isEmpty) {
                  return Center(
                    child: Text(
                      'No users found.',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  );
                }
                return _DemoContent(data: data);
              },
            );
          },
        ),
      ),
    );
  }
}

class _DemoContent extends StatelessWidget {
  final DemoModel data;

  const _DemoContent({required this.data});

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
                  'Flow: Page (Direct DI) → Bloc → UseCase → Repository → ResponseHandler',
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
                'Live Users List',
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
                  '${data.users.length} Users Loaded',
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
          ...data.users.map((user) => _UserCard(user: user)),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final DemoUserModel user;

  const _UserCard({required this.user});

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
