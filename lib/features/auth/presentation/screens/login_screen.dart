import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/textformfield_validators.dart';
import '../widgets/auth_screen.dart';
import '../widgets/auth_submit_button.dart';
import '../manager/auth_cubit.dart';
import '../widgets/auth_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, Routes.main);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: AppColors.secondaryColor),
          );
        }
      },
      child: AuthScreen(
        titleKey: "Login",
        formKey: _formKey,
        children: [
          AuthTextFormField(
            controller: emailController,
            hintText: "Email",
            validator: Validators.validateEmail,
          ),
          SizedBox(height: 20.h),
          AuthTextFormField(
            controller: passwordController,
            hintText: "Password",
            validator: Validators.validatePassword,
            obscureText: _obscurePassword,
            toggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AuthSubmitButton(
                title: "Login",
                isLoading: state is AuthLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
                      emailController.text.trim(),
                      passwordController.text,
                    );
                  }
                },
              );
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?", style: TextStyle(fontSize: 14.sp)),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, Routes.register),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
