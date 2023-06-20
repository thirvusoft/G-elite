import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/notificationcontroller.dart';
import '../utils/colors.dart';

class Notification extends StatefulWidget {
  Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final Notificationcontroller notificontroller =
      Get.put(Notificationcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            PhosphorIcons.caret_left,
          ),
        ),
        title: Text(
          'Notification',
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: AppColors.scaffoldBackgroundColor,
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notificontroller.notificationLists.length,
          itemBuilder: (BuildContext context, int index) {
            final Notification = notificontroller.notificationLists[index];
            return ListTile(
              title: Text(Notification.description),
            );
          },
        ),
      ),
    );
  }
}
