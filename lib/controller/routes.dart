import 'package:gelite/view/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class Routes {
  static String screen1 = '/login';
  static String screen2 = '/screen2';
  static String screen3 = '/screen3';
  static String screen4 = '/screen4';
  static String screen5 = '/screen5';
  static String screen6 = '/screen6';
}

/// Add this list variable into your GetMaterialApp as the value of getPages parameter.
/// You can get the reference to the above GetMaterialApp code.
final getPages = [
  GetPage(
    name: Routes.screen1,
    page: () => const Login(),
  ),
// GetPage(
//     name: Routes.screen2,
//     page: () => const Screen2(),
//   ),
//   GetPage(
//     name: Routes.screen3,
//     page: () => const Screen3(),
//   ),
//   GetPage(
//     name: Routes.screen4,
//     page: () => const Screen4(),
//   ),
//   GetPage(
//     name: Routes.screen5,
//     page: () => const Screen5(), 
//   ),
//   GetPage(
//     name: Routes.screen6,
//     page: () => const Screen6(),
//   ),
];