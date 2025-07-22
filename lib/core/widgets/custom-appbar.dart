import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.titleKey,
    this.actions,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(color: AppColors.offWhite),
      title: Text(
        titleKey,
        style: GoogleFonts.cairo(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.offWhite,
        ),
      ),
      actions: actions,
    );
  }
}
