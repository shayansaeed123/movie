import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/res/colors/app_color.dart';
import 'package:movie/res/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        iconTheme: IconThemeData(color: AppColor.blackColor),
        appBarTheme: AppBarTheme(color: AppColor.redColor),
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

