import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/services/auth_services.dart';
import 'package:news_app/presentation/login_screen.dart';
import 'package:news_app/presentation/news_screen.dart';
import 'package:news_app/presentation/widgets/custom_button.dart';
import 'package:news_app/presentation/widgets/custom_rich_text.dart';
import 'package:news_app/presentation/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _signup() async {
    setState(() {
      isLoading = true;
    });
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showSnackbar(context, 'All fields are required');
    } else {
      final message = await AuthServices()
          .signup(email: email, password: password, name: name);

      if (message == 'Signed up successfully') {
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
    _nameController.dispose();
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
                SizedBox(height: 150.h),
                CustomTextField(
                  hintText: "Name",
                  controller: _nameController,
                ),
                SizedBox(height: 20.h),
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
                CustomButton(label: 'Signup', onPressed: _signup),
                SizedBox(height: 13.h),
                CustomRichText(
                    regularText: 'Already have an account? ',
                    clickableText: 'Login',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }),
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
