import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom-appbar.dart';

class AuthScreen extends StatelessWidget {
  final String titleKey;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const AuthScreen({
    super.key,
    required this.titleKey,
    required this.formKey,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleKey: titleKey),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/chef.png',
                    height: 100,
                    width:100,
                  ),
                  SizedBox(height: 20.h),
                  // SizedBox(height: 150.h),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
