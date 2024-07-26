import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/colors.dart';
import 'package:news_app/views/login_screen.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/views/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'News App',
          theme: ThemeData(
            scaffoldBackgroundColor: kMistBlue,
            fontFamily: "Poppins",
            useMaterial3: false,
            textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 21.sp / 14.sp,
                  color: Colors.black),
              bodyLarge: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 21.sp / 14.sp,
                  color: Colors.black),
            ),
          ),
          home: const SignupScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
