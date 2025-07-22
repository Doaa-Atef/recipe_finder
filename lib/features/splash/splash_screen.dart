import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_finder/core/routes/routes.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/shared_prefs/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    await SharedPrefs.init();
    final uid = SharedPrefs.getUserId();

    Future.delayed(const Duration(seconds: 1), () {
      if (uid != null) {
        Navigator.pushReplacementNamed(context, Routes.main);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: OverflowBox(
                maxHeight: 300,
                maxWidth: 300,
                child: Lottie.asset(
                  'assets/Animation-donut.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            // const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, opacity, child) {
                return Opacity(opacity: opacity, child: child);
              },
              child: Text(
                'Recipe Finder',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.darkBrown,
                fontWeight: FontWeight.w500,
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    'Discover your favorite recipe',
                    speed: Duration(milliseconds: 50),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
