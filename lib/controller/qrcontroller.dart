import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_phosphor_icons/flutter_phosphor_icons.dart";
import "package:gelite/controller/eventcontroller.dart";
import "package:gelite/controller/userlistcontroller.dart";
import "package:gelite/models/uselist.dart";
import "package:gelite/utils/helper.dart";
import "package:get/get.dart";
import "package:get/get_navigation/src/snackbar/snackbar.dart";
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../utils/colors.dart";

class QRController extends GetxController {
  var responsedata = "";
  final Eventcontroller eventcontroller = Get.put(Eventcontroller());

  Future<void> attendance(name) async {
    await dotenv.load();
    print("12212222121222221");
    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.attendance"),
        body: {'name': jsonDecode(name), 'user': prefs.getString('full_name')},
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        eventcontroller.fetchEvents();
        eventcode = "";

        var value = jsonDecode(response.body);

        Get.snackbar(
          "Success",
          value["message"],
          icon: const Icon(
            PhosphorIcons.check_circle_fill,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {
        var value = jsonDecode(response.body);

        Get.snackbar(
          "Error",
          value["message"],
          icon: const Icon(
            PhosphorIcons.x_circle,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
    return null;
  }
}
