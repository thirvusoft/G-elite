import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../controller/eventcontroller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final Eventcontroller eventcontroller = Get.put(Eventcontroller());
  TabController? _tabController;
  late Timer timer;

  bool _result = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _result = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/Background.png',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                        )),
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed("/profile");
                                },
                                child: const CircleAvatar(
                                  radius: 26,
                                  backgroundImage:
                                      AssetImage('assets/profile.png'),
                                )),
                            const SizedBox(
                              width: 280,
                            ),
                            IconButton(
                              icon: const Icon(
                                PhosphorIcons.bell,
                              ),
                              color: AppColors.scaffoldBackgroundColor,
                              onPressed: () {},
                            ),
                          ],
                        )),
                    Positioned(
                        top: 90,
                        left: 10,
                        child: Column(
                          children: [
                            Text(
                              "Vignesh M",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    color: AppColors.scaffoldBackgroundColor,
                                    letterSpacing: .5,
                                    fontSize: 28),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Kootam - Pillar Kulam",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    color: AppColors.scaffoldBackgroundColor,
                                    letterSpacing: .5,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          tabs: const [
                            Tab(
                              text: "Today",
                            ),
                            Tab(
                              text: "Upcoming",
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
                          child:
                              TabBarView(controller: _tabController, children: [
                            SizedBox(
                                width: 10,
                                height: 10,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: (_result)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: LoadingAnimationWidget
                                                    .discreteCircle(
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                  secondRingColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Obx(
                                            () => ListView.builder(
                                                itemCount: eventcontroller
                                                    .eventList.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var count = index + 1;
                                                  final event = eventcontroller
                                                      .eventList[index];

                                                  return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/qr");
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      15)),
                                                          child: ListTile(
                                                              leading: CircleAvatar(
                                                                  backgroundColor: AppColors
                                                                      .secondaryColor,
                                                                  child: Text(count
                                                                      .toString())),
                                                              subtitle: Text(event
                                                                  .startsOn
                                                                  .toString()),
                                                              trailing: Icon(
                                                                  PhosphorIcons
                                                                      .caret_right,
                                                                  color: AppColors.primaryColor),
                                                              title: Text(event.name.toString()))));
                                                }),
                                          ))),
                            SizedBox(
                                width: 10,
                                height: 10,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: (_result)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: LoadingAnimationWidget
                                                    .discreteCircle(
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                  secondRingColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Obx(
                                            () => ListView.builder(
                                                itemCount: eventcontroller
                                                    .eventLists.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var count = index + 1;
                                                  final event = eventcontroller
                                                      .eventLists[index];

                                                  return GestureDetector(
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      15)),
                                                          child: ListTile(
                                                              leading: CircleAvatar(
                                                                  backgroundColor: AppColors
                                                                      .secondaryColor,
                                                                  child: Text(count
                                                                      .toString())),
                                                              subtitle: Text(event
                                                                  .startsOn
                                                                  .toString()),
                                                              trailing: Icon(
                                                                  PhosphorIcons
                                                                      .caret_right,
                                                                  color: AppColors.primaryColor),
                                                              title: Text(event.name.toString()))));
                                                }),
                                          ))),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
