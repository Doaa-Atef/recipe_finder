import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';

class RecipeTitle extends StatelessWidget {
  final String title;
  const RecipeTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
