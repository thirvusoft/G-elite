import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/models/event.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/signupcontroller.dart';
import '../controller/userlistcontroller.dart';
import '../utils/colors.dart';

class Userlist extends StatefulWidget {
  const Userlist({
    super.key,
  });

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final UserController usercontroller = Get.put(UserController());
  late Timer timer;

  bool isTextFieldVisible = false;
  double textFieldOpacity = 0.0;
  bool _result = true;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _result = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          centerTitle: true,
          title: isTextFieldVisible
              ? Container(
                  height: (MediaQuery.of(context).size.height) / 15,
                  width: (MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 18),
                        hintText: "Search User",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Icon(PhosphorIcons.magnifying_glass,
                              size: 20, color: AppColors.textcolour),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.iconcolor,
                              child: IconButton(
                                icon: Icon(
                                  color: AppColors.scaffoldBackgroundColor,
                                  PhosphorIcons.funnel_simple,
                                ),
                                onPressed: () {},
                              )),
                        ),
                      )),
                )
              : Text(
                  'User List',
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      color: AppColors.scaffoldBackgroundColor,
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isTextFieldVisible = !isTextFieldVisible;
                });
              },
              icon: (!isTextFieldVisible)
                  ? const Icon(
                      PhosphorIcons.magnifying_glass,
                      size: 20,
                    )
                  : const Icon(
                      PhosphorIcons.x,
                      size: 20,
                    ),
            ),
          ],
        ),
        body: (_result)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: AppColors.primaryColor,
                      size: 30,
                      secondRingColor: Colors.white,
                    ),
                  ),
                ],
              )
            : Obx(
                () => ListView.builder(
                    itemCount: usercontroller.userlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = usercontroller.userlist[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(user.userImage.toString()),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    PhosphorIcons.phone_call,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () async {
                                    var number = user.mobileNuber;
                                    if (number.length >= 10) {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          number);
                                    }
                                  },
                                ),
                                subtitle: Text(user.mobileNuber.toString()),
                                title: Text(user.fullName.toString()))),
                      );
                    }),
              ));
  }
}
