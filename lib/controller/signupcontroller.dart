import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_phosphor_icons/flutter_phosphor_icons.dart";
import "package:gelite/utils/colors.dart";
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";

class Signupcontroller extends GetxController {
  var responsedata = ''.obs;
  Future signUp(data) async {
    try {
      var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.sign_up"),
          body: {'data': data});
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        responsedata.value = response.body;
        Get.snackbar(
          "Success",
          value["User"],
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
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
    return null;
  }
}
