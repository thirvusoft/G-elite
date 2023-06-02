import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/profile.dart';
import '../utils/colors.dart';

class ProfileController extends GetxController {
  var profileDetails = [].obs;
  var responsedata = ''.obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.getString('token').toString());
      print("ppppppppp");
      print(prefs.getString('full_name'));
      await dotenv.load();
      var response = await http.get(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.profile_list?user=${prefs.getString('full_name')}",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.statusCode);
      var eventsJson = jsonDecode(response.body)['profile_list'] as List;
      print(eventsJson);
      profileDetails.value =
          eventsJson.map((details) => Profile.fromJson(details)).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future profileUpdation(data) async {
    await dotenv.load();

    try {
      var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.profile_update"),
          body: {'data': data});
      print(response.body);
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        responsedata.value = response.body;
        Get.snackbar(
          "Success",
          value["profile"],
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
        responsedata.value = response.body;
        Get.snackbar(
          "Error",
          value["profile"],
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
