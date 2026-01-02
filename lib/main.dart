import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/module/binding/home_binding.dart';
import 'package:hanuman_mandir/src/module/view/home/header/header_view.dart';
import 'package:hanuman_mandir/src/module/view/home_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sri Hanuman',
          initialBinding: HomeBinding(),
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
            ),
            useMaterial3: true,
          ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, .touch, .stylus, .unknown},
          ),
          home: const HomeView(),
        );
      },
    );
  }
}
