import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';

class BaseStateWidget extends StatelessWidget {
  final BaseStateStatus status;
  final Widget Function() onSuccess;
  final Widget Function()? onLoading;
  final Widget Function()? onEmpty;
  final Widget Function(String? error)? onError;
  final Widget Function()? onInitial;
  final Widget Function()? onNoInternet;
  final String? errorMessage;
  final String? emptyMessage;
  final String? loadingMessage;
  final String? noInternetMessage;
  final VoidCallback? onRetry;

  const BaseStateWidget({
    super.key,
    required this.status,
    required this.onSuccess,
    this.onLoading,
    this.onEmpty,
    this.onError,
    this.onInitial,
    this.onNoInternet,
    this.errorMessage,
    this.emptyMessage,
    this.loadingMessage,
    this.noInternetMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      BaseStateStatus.initial => onInitial?.call() ?? _buildInitial(context),
      BaseStateStatus.loading => onLoading?.call() ?? _buildLoading(context),
      BaseStateStatus.success => onSuccess(),
      BaseStateStatus.empty => onEmpty?.call() ?? _buildEmpty(context),
      BaseStateStatus.failure =>
        onError?.call(errorMessage) ?? _buildError(context),
      BaseStateStatus.noInternet =>
        onNoInternet?.call() ?? _buildNoInternet(context),
    };
  }

  Widget _buildInitial(BuildContext context) {
    return const Offstage();
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (loadingMessage != null) ...[
            SizedBox(height: 16.h),
            Text(
              loadingMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64.sp,
            color: Theme.of(context).disabledColor,
          ),
          SizedBox(height: 16.h),
          Text(
            emptyMessage ?? S.of(context).noDataAvailable,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              errorMessage ?? S.of(context).somethingWentWrong,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(S.of(context).retry),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoInternet(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              noInternetMessage ?? S.of(context).noInternetConnection,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(S.of(context).retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A Sliver version of BaseStateWidget for use in CustomScrollView
class BaseStateSliverWidget extends StatelessWidget {
  final BaseStateStatus status;
  final Widget Function() onSuccess;
  final Widget Function()? onLoading;
  final Widget Function()? onEmpty;
  final Widget Function(String? error)? onError;
  final Widget Function()? onInitial;
  final Widget Function()? onNoInternet;
  final String? errorMessage;
  final String? emptyMessage;
  final String? loadingMessage;
  final String? noInternetMessage;
  final VoidCallback? onRetry;

  const BaseStateSliverWidget({
    super.key,
    required this.status,
    required this.onSuccess,
    this.onLoading,
    this.onEmpty,
    this.onError,
    this.onInitial,
    this.onNoInternet,
    this.errorMessage,
    this.emptyMessage,
    this.loadingMessage,
    this.noInternetMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (status == BaseStateStatus.success) {
      return onSuccess();
    }

    return SliverFillRemaining(
      hasScrollBody: false,
      child: BaseStateWidget(
        status: status,
        onSuccess: () => const SizedBox.shrink(),
        onLoading: onLoading,
        onEmpty: onEmpty,
        onError: onError,
        onInitial: onInitial,
        onNoInternet: onNoInternet,
        errorMessage: errorMessage,
        emptyMessage: emptyMessage,
        loadingMessage: loadingMessage,
        noInternetMessage: noInternetMessage,
        onRetry: onRetry,
      ),
    );
  }
}
