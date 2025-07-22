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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150.h),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
