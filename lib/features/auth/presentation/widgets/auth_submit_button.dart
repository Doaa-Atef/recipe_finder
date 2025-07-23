import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';

class AuthSubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

   AuthSubmitButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ?  Center(child: CircularProgressIndicator())
        : ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50.h)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: AppColors.offWhite,
        ),
      ),
    );
  }
}
