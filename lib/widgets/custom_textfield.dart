import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(width: 1.h, color: kPrimaryColor),
        ),
      ),
    );
  }
}
