import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/core/routes/routes.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import 'package:recipe_finder/core/utils/textformfield_validators.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/auth_screen.dart';
import '../../../../core/dependency_injection/di.dart';
import '../manager/auth_cubit.dart';
import '../widgets/auth_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registered successfully"),
                backgroundColor: AppColors.primaryColor,
              ),
            );
            Navigator.pushReplacementNamed(context, Routes.login);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.secondaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          return AuthScreen(
            titleKey: "Sign Up",
            formKey: _formKey,
            children: [
              AuthTextFormField(
                controller: nameController,
                hintText: "Name",
                validator: Validators.validateName,
              ),
              SizedBox(height: 20.h),
              AuthTextFormField(
                controller: emailController,
                hintText: "Email",
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 20.h),
              AuthTextFormField(
                controller: passwordController,
                hintText: "Password",
                obscureText: _obscurePassword,
                toggleObscure: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 20.h),
              AuthSubmitButton(
                title: "Sign Up",
                isLoading: state is AuthLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      nameController.text.trim(),
                    );
                  }
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
