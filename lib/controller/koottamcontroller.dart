import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class Koottamcontroller extends GetxController {
  var kottom = [].obs;
  var district = [].obs;
  var area = [].obs;
  var user = [].obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      await dotenv.load();
      var response = await http.get(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.lists"),
      );

      var kottamJson = jsonDecode(response.body)['kootam_kovil_list'] as List;
      district.value = jsonDecode(response.body)['state'] as List;
      user.value = jsonDecode(response.body)['user_list'] as List;
      kottom.value = kottamJson.map((k) => k.toString()).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchArea(district) async {
    try {
      await dotenv.load();
      var body = {
        'district': district,
      };
      var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.area_list"),
          body: body);

      area.value = jsonDecode(response.body)['area'] as List;
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
 Future newkottam(data) async
 {
  final prefs = await SharedPreferences.getInstance();
        await dotenv.load();
         var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.kootam_kovil_details"),
              headers: 
              {
                "Authorization":prefs.getString('token').toString(),
              }
              ,
          body: {
            "data":jsonEncode(data)
          }
      
          );
          print(response.body);
          print(response.statusCode);

 }
  Future eventCreations(data) async {
    print("dddddddddddddddddd");
    print(data);

    try {
      await dotenv.load();
      var body = {
        'data': data,
      };
      print(body);
      var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.event_creation"),
          body: body);

      print(response.body);
      if (response.statusCode == 200) {
        Get.back();
        print("ddddddddddddddadasddsdasdasdasd");
        var value = jsonDecode(response.body);
        print(value);
        print("ddddddddddddddadasddsdasdasdasd");

        Get.snackbar(
          "Success",
          value["Event"],
          icon: const Icon(
            PhosphorIcons.check_circle_fill,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          forwardAnimationCurve: Curves.bounceIn,
        );
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
