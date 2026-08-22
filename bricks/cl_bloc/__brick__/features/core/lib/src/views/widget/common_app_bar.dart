import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color:
              foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      leading:
          leading ??
          (showBackButton && Navigator.canPop(context)
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              )
              : null),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
