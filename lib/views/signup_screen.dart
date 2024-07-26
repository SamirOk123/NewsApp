import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/colors.dart';
import 'package:news_app/views/login_screen.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_rich_text.dart';
import 'package:news_app/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            SizedBox(height: 150.h),
            const CustomTextField(
              hintText: "Name",
            ),
            SizedBox(height: 20.h),
            const CustomTextField(
              hintText: "Email",
            ),
            SizedBox(height: 20.h),
            const CustomTextField(
              hintText: "Password",
            ),
            SizedBox(height: 250.h),
            CustomButton(label: 'Signup', onPressed: () {}),
            SizedBox(height: 13.h),
            CustomRichText(
              regularText: 'Already have an account? ',
              clickableText: 'Login',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
