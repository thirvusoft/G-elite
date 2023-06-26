import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controller/bannercontroller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  void initState() {
    super.initState();
    final Bannerevent bannerevent = Get.put(Bannerevent());

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
    print(token.getString("roll"));

    // Get.lazyPut(() => Bannerevent());
    // Get.find<Bannerevent>().bannerList();
    if (token.getString('token') == null) {
      timer =
          Timer(const Duration(seconds: 3), () => Get.offAllNamed("/login"));
    } else if (token.getString('roll') == "super_admin") {
      timer = Timer(
          const Duration(seconds: 3), () => Get.offAllNamed("/landingPage1"));
    } else if (token.getString('roll') == " ") {
      timer = Timer(
          const Duration(seconds: 3), () => Get.offAllNamed("/LandingPage"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor1,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text.rich(
                TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 50,
                    color: AppColors.backgroundColor,
                    letterSpacing: 2.000000061035156,
                  ),
                  children: [
                    const TextSpan(
                      text: "G -",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: ' ELITE',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: AppColors.iconcolor,
                  size: 40,
                ),
              )
            ]),
          ),
        ));
  }
}
