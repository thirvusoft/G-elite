import 'package:gelite/view/bottomnavigation1.dart';
import 'package:gelite/view/evencreation.dart';
import 'package:gelite/view/login.dart';
import 'package:gelite/view/qr.dart';
import 'package:gelite/view/signup.dart';
import 'package:gelite/view/splashscreen.dart';
import 'package:gelite/view/test.dart';
import 'package:gelite/view/user_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../view/home_page.dart';
import '../view/bottomnavigation.dart';
import '../view/profile.dart';

class Routes {
  static String screen1 = '/login';
  static String screen2 = '/LandingPage';
  static String screen3 = '/Homepage';
  static String screen4 = '/Userlist';
  static String screen5 = '/signup';
  static String screen6 = '/profile';
  static String screen7 = '/filepicker';
  static String screen8 = '/qr';
  static String splashscreen = '/SplashScreen';
  static String eventcreation = '/EventCreation';
  static String landingPage1 = '/landingPage1';
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
    transition: Transition.fade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen3,
    page: () => const Homepage(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen4,
    page: () => Userlist(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen5,
    page: () => const Signup(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen6,
    page: () => const Profile(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen7,
    page: () => const MultipleFilepickerScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen8,
    page: () => const qr(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.splashscreen,
    page: () => const SplashScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.eventcreation,
    page: () => const EventCreation(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.landingPage1,
    page: () => LandingPage1(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
