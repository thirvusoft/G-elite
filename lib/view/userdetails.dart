// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/userdetailcontroller.dart';
import '../utils/colors.dart';
import '../widgets/bottomsheet.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class UserDetail extends StatelessWidget {
  final Userdetailscontroller eventcontroller =
      Get.put(Userdetailscontroller());
  TabController? _tabController;

  UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
            child: Column(children: [
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
                  right: 60,
                  child: Obx(
                    () => Column(
                      children: eventcontroller.userDetail
                          .map(
                            (user) => IconButton(
                              onPressed: () async {
                                Get.toNamed("/Bannerupload");
                              },
                              icon: const Icon(
                                PhosphorIcons.newspaper_clipping_light,
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
                  top: 90,
                  right: 15,
                  child: Obx(
                    () => Column(
                      children: eventcontroller.userDetail
                          .map(
                            (user) => IconButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  builder: (BuildContext context) =>
                                      Bottomsheet(
                                          fullName: user.fullName,
                                          mobileNo: user.mobileNo),
                                );
                              },
                              icon: const Icon(
                                PhosphorIcons.phone_outgoing_light,
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
                                            const Icon(PhosphorIcons.map_pin),
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
          const SizedBox(
            height: 10,
          ),
          DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          tabs: const [
                            Tab(
                              text: "User Info",
                            ),
                            Tab(
                              text: "Family Details",
                            ),
                            Tab(
                              text: "Organisation",
                            ),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          indicator: MaterialIndicator(
                            height: 5,
                            color: AppColors.iconcolor,
                            topLeftRadius: 5,
                            topRightRadius: 5,
                            bottomLeftRadius: 5,
                            bottomRightRadius: 5,
                            tabPosition: TabPosition.bottom,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: (MediaQuery.of(context).size.height) / 1.6,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SizedBox(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.5,
                                                child: Obx(
                                                  () => ListView.builder(
                                                    itemCount: eventcontroller
                                                        .userDetail.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final user =
                                                          eventcontroller
                                                                  .userDetail[
                                                              index];
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .backgroundColor,
                                                                    child: Icon(
                                                                      PhosphorIcons
                                                                          .at,
                                                                      color: AppColors
                                                                          .iconcolor,
                                                                    )),
                                                            title: Text(
                                                              'Email: ${(user.emailID == "") ? "-----" : user.emailID}',
                                                            ),
                                                            trailing:
                                                                IconButton(
                                                              icon: const Icon(
                                                                PhosphorIcons
                                                                    .caret_right,
                                                                size: 25,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                var id = user
                                                                    .emailID;
                                                                var uri =
                                                                    'mailto:$id?subject=Greetings&body=Hello';
                                                                if (await canLaunch(
                                                                    uri)) {
                                                                  await launch(
                                                                      uri);
                                                                } else {
                                                                  throw 'Could not launch $uri';
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .backgroundColor,
                                                                    child: Icon(
                                                                      PhosphorIcons
                                                                          .device_mobile,
                                                                      color: AppColors
                                                                          .iconcolor,
                                                                    )),
                                                            title: Text(
                                                                'MobileNo: ${user.mobileNo}'),
                                                            trailing:
                                                                IconButton(
                                                              icon: const Icon(
                                                                PhosphorIcons
                                                                    .caret_right,
                                                                size: 25,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if (user.mobileNo
                                                                        .length >=
                                                                    10) {
                                                                  await launch(
                                                                      "https://wa.me/${user.mobileNo}?text=Hello");
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .backgroundColor,
                                                                    child: Icon(
                                                                      PhosphorIcons
                                                                          .map_pin,
                                                                      color: AppColors
                                                                          .iconcolor,
                                                                    )),
                                                            title: Text(
                                                                'Territory: ${(user.territory == "") ? " ---" : user.territory}'),
                                                          ),
                                                          const Divider(),
                                                          ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .backgroundColor,
                                                                    child: Icon(
                                                                      PhosphorIcons
                                                                          .users_three,
                                                                      color: AppColors
                                                                          .iconcolor,
                                                                    )),
                                                            title: Text(
                                                                'KootamKovil: ${(user.kootamKovil == "") ? " ---" : user.kootamKovil}'),
                                                          ),
                                                          const Divider(),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))),
                              SizedBox(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Obx(
                                          () => ListView.builder(
                                            itemCount: eventcontroller
                                                .userFamily.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final user = eventcontroller
                                                  .userFamily[index];
                                              print(eventcontroller.userFamily);
                                              return Column(
                                                children: [
                                                  const Divider(),
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .gender_male,
                                                          color: AppColors
                                                              .iconcolor,
                                                        )),
                                                    title: Text(
                                                        'Father : ${(user.fathersName == "") ? "---" : user.fathersName}'),
                                                  ),
                                                  const Divider(),
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .gender_female,
                                                          color: AppColors
                                                              .iconcolor,
                                                        )),
                                                    title: Text(
                                                        'Mother : ${(user.mothersName == "") ? " ---" : user.mothersName}'),
                                                  ),
                                                  const Divider(),
                                                  ListTile(
                                                      leading: CircleAvatar(
                                                          backgroundColor:
                                                              AppColors
                                                                  .backgroundColor,
                                                          child: Icon(
                                                            PhosphorIcons
                                                                .identification_badge,
                                                            color: AppColors
                                                                .iconcolor,
                                                          )),
                                                      title: Text(
                                                          'Spouse/Husband Name:${(user.spouseHusbandName == "") ? " ---" : user.spouseHusbandName}')

                                                      // ${(user.kootamKovil == "") ? " ---" : user.kootamKovil}'),
                                                      ),
                                                  const Divider(),
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                        child: Icon(
                                                          PhosphorIcons.phone,
                                                          color: AppColors
                                                              .iconcolor,
                                                        )),
                                                    title: Text(
                                                        'Spouse/Husband Mobile Number:${(user.spouseHusbandMobileNumber == "") ? " ---" : user.spouseHusbandMobileNumber}'),

                                                    // ${(user.kootamKovil == "") ? " ---" : user.kootamKovil}'),
                                                  ),
                                                  const Divider(),
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .users_three,
                                                          color: AppColors
                                                              .iconcolor,
                                                        )),
                                                    title: Text(
                                                        'Spouse/Husband Kootamkovil:${(user.spouseHusbandKootamKovil == "") ? " ---" : user.spouseHusbandKootamKovil}'),

                                                    // ${(user.kootamKovil == "") ? " ---" : user.kootamKovil}'),
                                                  ),
                                                  const Divider(),
                                                  ListTile(
                                                      leading: CircleAvatar(
                                                          backgroundColor:
                                                              AppColors
                                                                  .backgroundColor,
                                                          child: Icon(
                                                            PhosphorIcons
                                                                .calendar,
                                                            color: AppColors
                                                                .iconcolor,
                                                          )),
                                                      title: Text(
                                                          'Anniversary Date:${(user.anniversaryDate == "") ? " ---" : user.anniversaryDate}')),
                                                  const Divider(),
                                                  // ListTile(
                                                  //   leading: CircleAvatar(
                                                  //       backgroundColor:
                                                  //           AppColors
                                                  //               .backgroundColor,
                                                  //       child: Icon(
                                                  //         PhosphorIcons.baby,
                                                  //         color: AppColors
                                                  //             .iconcolor,
                                                  //       )),
                                                  //   title: Text(
                                                  //       'Children Details:'),
                                                  //   // {(user.childrenDetails['dateOfBirth'].toString() == "") ? " ---" : user.childrenDetails['dateOfBirth'].toString()}'),
                                                  // ),
                                                  // const Divider(),
                                                  // ListTile(
                                                  //   leading: CircleAvatar(
                                                  //       backgroundColor:
                                                  //           AppColors
                                                  //               .backgroundColor,
                                                  //       child: Icon(
                                                  //         PhosphorIcons.baby,
                                                  //         color: AppColors
                                                  //             .iconcolor,
                                                  //       )),
                                                  //   title: Text(
                                                  //       'Children Details:'),
                                                  //   // ${(user.childrenDetails == "") ? " ---" : user.childrenDetails}'),
                                                  // ),
                                                  // const Divider(),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              )),
                              SizedBox(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.5,
                                              child: Obx(
                                                () => ListView.builder(
                                                  itemCount: eventcontroller
                                                      .userOrg.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final user = eventcontroller
                                                        .userOrg[index];
                                                    return Column(
                                                      children: [
                                                        const Divider(),
                                                        ListTile(
                                                          leading: CircleAvatar(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .backgroundColor,
                                                              child: Icon(
                                                                PhosphorIcons
                                                                    .buildings,
                                                                color: AppColors
                                                                    .iconcolor,
                                                              )),
                                                          title: Text(
                                                              'Company Name: ${(user.companyName == "") ? " ---" : user.companyName}'),
                                                        ),
                                                        const Divider(),
                                                        ListTile(
                                                          leading: CircleAvatar(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .backgroundColor,
                                                              child: Icon(
                                                                PhosphorIcons
                                                                    .factory,
                                                                color: AppColors
                                                                    .iconcolor,
                                                              )),
                                                          title: Text(
                                                              'Industry Type: ${(user.industryType == "") ? " ---" : user.industryType}'),
                                                        ),
                                                        const Divider(),
                                                        ListTile(
                                                          leading: CircleAvatar(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .backgroundColor,
                                                              child: Icon(
                                                                PhosphorIcons
                                                                    .map_pin,
                                                                color: AppColors
                                                                    .iconcolor,
                                                              )),
                                                          title: Text(
                                                              'Address:${(user.address == "") ? " ---" : user.address}'),
                                                        ),
                                                        const Divider(),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ]))))
        ])));
  }
}
