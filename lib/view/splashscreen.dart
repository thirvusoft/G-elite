import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  void initState() {
    super.initState();
    time();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Future time() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    print(token.getString("token"));

    if (token.getString('token') == null) {
      timer =
          Timer(const Duration(seconds: 2), () => Get.offAllNamed("/login"));
    } else if (token.getString('roll') == "super_admin") {
      timer = Timer(
          const Duration(seconds: 2), () => Get.offAllNamed("/landingPage1"));
    } else {
      timer = Timer(
          const Duration(seconds: 2), () => Get.offAllNamed("/LandingPage"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(child: Image.asset("assets/G-Elite.gif")));
  }
}
