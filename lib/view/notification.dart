import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/notificationcontroller.dart';
import '../models/time.dart';
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
        () => ListView.separated(
          itemCount: notificontroller.notificationLists.length,
          itemBuilder: (BuildContext context, int index) {
            final notification = notificontroller.notificationLists[index];
            print(notificontroller.notificationLists.length);
            var result = timeAgoCustom(DateTime.parse(notification.date));
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.backgroundColor,
                child: Text(
                  notification.username[0],
                  style: TextStyle(color: AppColors.iconcolor),
                ),
              ),
              title: Text(
                notification.username + " " + notification.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(result.toString()),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
