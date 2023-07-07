import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/colors.dart';
import 'package:gelite/utils/helper.dart';
import 'package:gelite/view/user_list.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:heroicons/heroicons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controller/eventcontroller.dart';
import '../controller/userlistcontroller.dart';
import 'businesscard.dart';
import 'home_page.dart';

class LandingPageControllers extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (tabIndex.value == 1) {
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchEvents();
      } else {
        final UserController usercontroller = Get.put(UserController());
        usercontroller.fetchEvents();
      }
    } else {
      if (Get.isRegistered<Eventcontroller>()) {
        Get.find<Eventcontroller>().fetchEvents();
        result = false;
      } else {
        final Eventcontroller usercontroller = Get.put(Eventcontroller());
        usercontroller.fetchEvents();
      }
    }
  }
}

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: AppColors.secondaryColor,
            unselectedItemColor: const Color(0xff05944a),
            selectedItemColor: AppColors.primaryColor,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: ZoomTapAnimation(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    PhosphorIcons.house,
                    size: 20.0,
                  ),
                )),
                label: 'Home',
                backgroundColor: AppColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: ZoomTapAnimation(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: Icon(
                    PhosphorIcons.user,
                    size: 20.0,
                    color: AppColors.primaryColor,
                  ),
                )),
                label: 'User',
                backgroundColor: AppColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: ZoomTapAnimation(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: const HeroIcon(
                          HeroIcons.creditCard,
                          size: 20.0,
                        ))),
                label: 'Card',
                backgroundColor: AppColors.primaryColor,
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageControllers landingPageController =
        Get.put(LandingPageControllers(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: const [Homepage(), Userlist(), Businesscard()],
          )),
    ));
  }
}
