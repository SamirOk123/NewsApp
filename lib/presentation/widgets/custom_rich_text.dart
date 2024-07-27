import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/colors.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.regularText,
    required this.clickableText,
    this.onTap,
  });

  final String regularText;
  final String clickableText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: regularText,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 24.sp / 16.sp),
          ),
          TextSpan(
            text: clickableText,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                height: 24.sp / 16.sp,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
