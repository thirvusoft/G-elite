import 'package:gelite/view/bottomnavigation1.dart';
import 'package:gelite/view/evencreation.dart';
import 'package:gelite/view/login.dart';
import 'package:gelite/view/qr.dart';
import 'package:gelite/view/signup.dart';
import 'package:gelite/view/splashscreen.dart';
import 'package:gelite/view/test.dart';
import 'package:gelite/view/user_list.dart';
import 'package:get/get.dart';
import '../view/bannerupload.dart';
import '../view/businessdetails.dart';
import '../view/eventcreatioadmin.dart';
import '../view/home_page.dart';
import '../view/bottomnavigation.dart';
import '../view/notification.dart';
import '../view/profile.dart';
import '../view/userdetails.dart';

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
  static String UserDetail = '/UserDetail';
  static String Notification = '/Notification';
  static String bannerupload = '/Bannerupload';
  static String eventsadmin = '/Eventsadmin';
  static String businessdetails = '/businessdetails';
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
    // transition: Transition.fade,
    // transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.screen3,
    page: () => const Homepage(),
  ),
  GetPage(
    name: Routes.screen4,
    page: () => Userlist(),
  ),
  GetPage(
    name: Routes.screen5,
    page: () => const Signup(),
  ),
  GetPage(
    name: Routes.screen6,
    page: () => const Profile(),
  ),
  GetPage(
    name: Routes.screen7,
    page: () => const MultipleFilepickerScreen(),
  ),
  GetPage(
    name: Routes.screen8,
    page: () => const qr(),
  ),
  GetPage(
    name: Routes.splashscreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: Routes.eventcreation,
    page: () => const EventCreation(),
  ),
  GetPage(
    name: Routes.landingPage1,
    page: () => const LandingPage1(),
  ),
  GetPage(
    name: Routes.UserDetail,
    page: () => UserDetail(),
  ),
  GetPage(
    name: Routes.Notification,
    page: () => Notification(),
  ),
  GetPage(
    name: Routes.bannerupload,
    page: () => Bannerupload(),
  ),
  GetPage(
    name: Routes.eventsadmin,
    page: () => Eventsadmin(),
  ),
  GetPage(
    name: Routes.businessdetails,
    page: () => Businessdetails(),
  ),
];
