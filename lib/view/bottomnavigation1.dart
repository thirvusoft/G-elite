import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/colors.dart';
import 'package:gelite/view/signup.dart';
import 'package:gelite/view/user_list.dart';
import 'package:get/get.dart';
import '../controller/eventcontroller.dart';
import '../controller/userlistcontroller.dart';
import 'evencreation.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (tabIndex.value == 2) {
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchEvents();
      } else {
        final UserController usercontroller = Get.put(UserController());
        usercontroller.fetchEvents();
      }
    } else if (tabIndex.value == 0) {
      Get.find<Eventcontroller>().fetchEventsadmin();
    }
  }
}

class LandingPage1 extends StatefulWidget {
  const LandingPage1({super.key});

  @override
  State<LandingPage1> createState() => _LandingPage1State();
}

class _LandingPage1State extends State<LandingPage1> {
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
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    PhosphorIcons.calendar_plus,
                    size: 20.0,
                  ),
                ),
                label: 'Event',
                backgroundColor: AppColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: Icon(
                    PhosphorIcons.user_plus,
                    size: 20.0,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'Register',
                backgroundColor: AppColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: Icon(
                    PhosphorIcons.user,
                    size: 20.0,
                    color: AppColors.primaryColor,
                  ),
                ),
                label: 'User List',
                backgroundColor: AppColors.primaryColor,
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: const [EventCreation(), Signup(), Userlist()],
          )),
    ));
  }
}
