import 'package:gelite/view/login.dart';
import 'package:gelite/view/user_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../view/home_page.dart';
import '../view/test.dart';

class Routes {
  static String screen1 = '/login';
  static String screen2 = '/LandingPage';
  static String screen3 = '/Homepage';
  static String screen4 = '/Userlist';
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
  GetPage(
    name: Routes.screen2,
    page: () => LandingPage(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen3,
    page: () => const Homepage(),
  ),
  GetPage(
    name: Routes.screen4,
    page: () => const Userlist(),
  ),
//   GetPage(
//     name: Routes.screen5,
//     page: () => const Screen5(),
//   ),
//   GetPage(
//     name: Routes.screen6,
//     page: () => const Screen6(),
//   ),
];