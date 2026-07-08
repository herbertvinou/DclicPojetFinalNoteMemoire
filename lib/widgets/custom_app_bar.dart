import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,

      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      )
          : null,

      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: true,

      actions: actions,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}