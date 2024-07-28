import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/textfield_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText,
    this.onchanged,
    this.validator,
    this.inputType,
    this.trailing,
    required this.isVisible,
  });

  final String hintText;
  final void Function(String)? onchanged;
  final bool? obscureText;
  final FormFieldValidator? validator;
  final TextInputType? inputType;
  final Widget? trailing;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Consumer<TextfieldProvider>(
      builder: (context, textfieldProvider, _) => TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onchanged,
        obscureText: isVisible,
        decoration: InputDecoration(
          suffixIcon: trailing,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 5,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.h, color: kPrimaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.h, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 2.h, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
