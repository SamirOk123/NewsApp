import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/login_provider.dart';
import 'package:news_app/application/signup_provider.dart';
import 'package:news_app/application/news_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/domain/di/injectable.dart';
import 'package:news_app/presentation/screens/login_screen.dart';
import 'package:news_app/presentation/screens/news_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureInjection();
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<NewsProvider>(
              create: (context) => getIt<NewsProvider>(),
            ),
            ChangeNotifierProvider<SignupProvider>(
              create: (context) => getIt<SignupProvider>(),
            ),
            ChangeNotifierProvider<LoginProvider>(
              create: (context) => getIt<LoginProvider>(),
            ),
          ],
          child: MaterialApp(
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
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return const NewsScreen();
                } else {
                  return const LoginScreen();
                }
              },
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
