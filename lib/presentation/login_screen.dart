import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/services/auth_services.dart';
import 'package:news_app/presentation/news_screen.dart';
import 'package:news_app/presentation/signup_screen.dart';
import 'package:news_app/presentation/widgets/custom_button.dart';
import 'package:news_app/presentation/widgets/custom_rich_text.dart';
import 'package:news_app/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    setState(() {
      isLoading = true;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showSnackbar(context, 'All fields are required');
    } else {
      final message =
          await AuthServices().login(email: email, password: password);

      if (message == 'Logged in successfully') {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewsScreen()),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackbar(context, message);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 70.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "MyNews",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                        height: 30.sp / 20.sp),
                  ),
                ),
                SizedBox(height: 192.h),
                CustomTextField(
                  hintText: "Email",
                  controller: _emailController,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                ),
                SizedBox(height: 250.h),
                CustomButton(
                  label: 'Login',
                  onPressed: _login,
                ),
                SizedBox(height: 13.h),
                CustomRichText(
                  regularText: 'New here? ',
                  clickableText: 'Signup',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
