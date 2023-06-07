// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/userdetailcontroller.dart';
import '../utils/colors.dart';

class UserDetail extends StatelessWidget {
  final Userdetailscontroller eventcontroller =
      Get.put(Userdetailscontroller());

  UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: AppColors.primaryColor,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                    ),
                    Positioned(
                        top: 90,
                        left: 10,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              PhosphorIcons.caret_left_bold,
                              color: Colors.white,
                              size: 25,
                            ))),
                    Positioned(
                      top: 90,
                      right: 15,
                      child: Obx(
                        () => Column(
                          children: eventcontroller.userDetail
                              .map(
                                (user) => IconButton(
                                  onPressed: () async {
                                    // const uri =
                                    //     'mailto:test@example.org?subject=Greetings&body=Hello%20World';
                                    // if (await canLaunch(uri)) {
                                    //   await launch(uri);
                                    // } else {
                                    //   throw 'Could not launch $uri';
                                    // }

                                    if (user.mobileNo.length >= 10) {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          user.mobileNo);
                                    }
                                  },
                                  icon: const Icon(
                                    PhosphorIcons.phone_outgoing,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 0,
                      right: 0,
                      child: Obx(() => Column(
                            children: eventcontroller.userDetail
                                .map((user) => CircleAvatar(
                                      radius: 60,
                                      backgroundImage: (user.userImage ==
                                              "http://events.thirvusoft.co.inNone")
                                          ? const NetworkImage(
                                              "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg")
                                          : NetworkImage(user.userImage),
                                    ))
                                .toList(),
                          )),
                    ),
                    Positioned(
                        top: 220,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Obx(() => Column(
                                  children: eventcontroller.userDetail
                                      .map((user) => Text(
                                            '${user.fullName} ',
                                            style: GoogleFonts.nunitoSans(
                                              textStyle: const TextStyle(
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => Column(
                                  children: eventcontroller.userDetail
                                      .map((user) => Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                const Icon(
                                                    PhosphorIcons.map_pin),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text((user.territory == "")
                                                    ? "-------"
                                                    : user.territory),
                                              ]))
                                      .toList(),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => Column(
                                  children: eventcontroller.userDetail
                                      .map((user) => Text(
                                            '${(user.companyName == "") ? " --- " : user.companyName}',
                                            style: GoogleFonts.nunitoSans(
                                              textStyle: const TextStyle(
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )),
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: eventcontroller.userDetail.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = eventcontroller.userDetail[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        var id = user.emailID;
                                        var uri =
                                            'mailto:$id?subject=Greetings&body=Hello';
                                        if (await canLaunch(uri)) {
                                          await launch(uri);
                                        } else {
                                          throw 'Could not launch $uri';
                                        }
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundColor:
                                                AppColors.backgroundColor,
                                            child: Icon(
                                              PhosphorIcons.at,
                                              color: AppColors.iconcolor,
                                            )),
                                        title: Text(
                                          'Email: ${(user.emailID == "") ? "-----" : user.emailID}',
                                        ),
                                      )),
                                  const Divider(),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        child: Icon(
                                          PhosphorIcons.gender_male,
                                          color: AppColors.iconcolor,
                                        )),
                                    title: Text(
                                        'Father: ${(user.fathersName == "") ? " ---" : user.fathersName}'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        child: Icon(
                                          PhosphorIcons.gender_female,
                                          color: AppColors.iconcolor,
                                        )),
                                    title: Text(
                                        'Mother : ${(user.mothersName == "") ? " ---" : user.mothersName}'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        child: Icon(
                                          PhosphorIcons.users_three,
                                          color: AppColors.iconcolor,
                                        )),
                                    title: Text(
                                        'KootamKovil: ${(user.kootamKovil == "") ? " ---" : user.kootamKovil}'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        child: Icon(
                                          PhosphorIcons.fingerprint_simple,
                                          color: AppColors.iconcolor,
                                        )),
                                    title: Text(
                                        'AadharNo: ${(user.aadharNo == "") ? " ---" : user.aadharNo}'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        child: Icon(
                                          PhosphorIcons.device_mobile,
                                          color: AppColors.iconcolor,
                                        )),
                                    title: Text('MobileNo: ${user.mobileNo}'),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
