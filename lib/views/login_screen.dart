import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/colors.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/views/signup_screen.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_rich_text.dart';
import 'package:news_app/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            const CustomTextField(
              hintText: "Email",
            ),
            SizedBox(height: 20.h),
            const CustomTextField(
              hintText: "Password",
            ),
            SizedBox(height: 250.h),
            CustomButton(
              label: 'Login',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()),
                );
              },
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
    );
  }
}
