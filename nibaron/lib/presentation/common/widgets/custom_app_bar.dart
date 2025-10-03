import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? additionalActions;
  final bool showBackButton;
  final double? toolbarHeight;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.additionalActions,
    this.showBackButton = true,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: showBackButton,
      toolbarHeight: toolbarHeight,
      title: titleWidget ?? (title != null ? Text(title!) : null),
      actions: [
        ...?additionalActions,
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.lightPrimary.withOpacity(0.15),
            foregroundColor: AppColors.lightPrimary,
            fixedSize: const Size(40, 40),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          icon: const Icon(Icons.person_outline),
          tooltip: 'Profile',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.lightPrimary.withOpacity(0.15),
            foregroundColor: AppColors.lightPrimary,
            fixedSize: const Size(40, 40),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
