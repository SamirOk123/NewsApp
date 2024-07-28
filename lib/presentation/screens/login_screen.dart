import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/login_provider.dart';
import 'package:news_app/application/textfield_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/presentation/screens/news_screen.dart';
import 'package:news_app/presentation/screens/signup_screen.dart';
import 'package:news_app/presentation/widgets/custom_button.dart';
import 'package:news_app/presentation/widgets/custom_rich_text.dart';
import 'package:news_app/presentation/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          loginProvider.loginFailureOrSuccess.fold(
            () {},
            (either) => either.fold(
              (failure) {
                final errorMessage = failure.maybeMap(
                  invalidEmail: (_) => "Invalid Email",
                  wrongPassword: (_) => "Wrong Password",
                  userNotFound: (_) => "User not found",
                  invalidUser: (_) => "Invalid user",
                  clientFailure: (_) => "Something went wrong",
                  serverFailure: (_) => "Something went wrong",
                  orElse: () => "Something went wrong",
                );

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showSnackbar(context, errorMessage);
                });
              },
              (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const NewsScreen()),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
          );
          final textfieldProvider =
              Provider.of<TextfieldProvider>(context, listen: false);
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: formKey,
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
                        isVisible: textfieldProvider.isVisible,
                        inputType: TextInputType.emailAddress,
                        onchanged: (value) {
                          loginProvider.emailChanged(email: value.trim());
                        },
                        validator: (value) =>
                            textfieldProvider.emailValidator(value),
                      ),
                      SizedBox(height: 20.h),
                      Consumer<TextfieldProvider>(
                        builder: (context, textfieldProvider, child) =>
                            CustomTextField(
                          hintText: "Password",
                          isVisible: textfieldProvider.isVisible,
                          validator: (value) => textfieldProvider.validator(
                              value, "Password is required"),
                          trailing: IconButton(
                            onPressed: () =>
                                textfieldProvider.showHidePassword(),
                            icon: Icon(!textfieldProvider.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          onchanged: (value) {
                            loginProvider.passwordChanged(
                                password: value.trim());
                          },
                        ),
                      ),
                      SizedBox(height: 250.h),
                      CustomButton(
                        label: 'Login',
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            loginProvider.login();
                          } else {
                            return;
                          }
                        },
                      ),
                      SizedBox(height: 13.h),
                      CustomRichText(
                        regularText: 'New here? ',
                        clickableText: 'Signup',
                        onTap: () {
                          Provider.of<LoginProvider>(context, listen: false)
                              .clearState();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (loginProvider.isSubmitting)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
