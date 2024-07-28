import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/login_provider.dart';
import 'package:news_app/application/signup_provider.dart';
import 'package:news_app/application/news_provider.dart';
import 'package:news_app/application/textfield_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/routes.dart';
import 'package:news_app/domain/di/injectable.dart';
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
    final AppRouter appRouter = AppRouter();
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
            ChangeNotifierProvider<TextfieldProvider>(
              create: (context) => getIt<TextfieldProvider>(),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: appRouter.config(),
            title: 'News App',
            theme: ThemeData(
              scaffoldBackgroundColor: kMistBlue,
              fontFamily: "Poppins",
              useMaterial3: true,
              colorSchemeSeed: kPrimaryColor,
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
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
