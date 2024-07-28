import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/signup_provider.dart';
import 'package:news_app/application/textfield_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/core/routes.gr.dart';
import 'package:news_app/presentation/widgets/custom_button.dart';
import 'package:news_app/presentation/widgets/custom_rich_text.dart';
import 'package:news_app/presentation/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignupProvider>(
        builder: (context, signupProvider, child) {
          signupProvider.authFailureOrSuccess.fold(
            () {},
            (either) => either.fold(
              (failure) {
                final errorMessage = failure.maybeMap(
                  emailAlreadyInUse: (_) => "Email already in use",
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
                  context.router.replaceAll([const NewsRoute()]);
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
                      SizedBox(height: 150.h),
                      CustomTextField(
                        hintText: "Name",
                        isVisible: false,
                        validator: (value) => textfieldProvider.validator(
                            value, "Name is required"),
                        onchanged: (value) {
                          signupProvider.nameChanged(name: value.trim());
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        hintText: "Email",
                        isVisible: false,
                        inputType: TextInputType.emailAddress,
                        validator: (value) =>
                            textfieldProvider.emailValidator(value),
                        onchanged: (value) {
                          signupProvider.emailChanged(email: value.trim());
                        },
                      ),
                      SizedBox(height: 20.h),
                      Consumer<TextfieldProvider>(
                        builder: (context, textfieldProvider, child) =>
                            CustomTextField(
                          isVisible: textfieldProvider.isVisible,
                          hintText: "Password",
                          validator: (value) =>
                              textfieldProvider.passwordValidator(value),
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
                            signupProvider.passwordChanged(
                                password: value.trim());
                          },
                        ),
                      ),
                      SizedBox(height: 230.h),
                      CustomButton(
                          label: 'Signup',
                          onPressed: () {
                            if (formKey.currentState?.validate() == true) {
                              signupProvider.signup();
                            } else {
                              return;
                            }
                          }),
                      SizedBox(height: 13.h),
                      CustomRichText(
                          regularText: 'Already have an account? ',
                          clickableText: 'Login',
                          onTap: () {
                            Provider.of<SignupProvider>(context, listen: false)
                                .clearState();
                            context.router.replace(LoginRoute());
                          }),
                    ],
                  ),
                ),
              ),
              if (signupProvider.isSubmitting)
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
