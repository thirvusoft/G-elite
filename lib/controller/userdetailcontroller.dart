import "dart:convert";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
import "package:flutter_phosphor_icons/flutter_phosphor_icons.dart";
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../models/userdetails.dart";
import "../utils/colors.dart";

class Userdetailscontroller extends GetxController {
  var userDetail = [].obs;
  var userFamily = [].obs;
  var userOrg = [].obs;
  final _response = ''.obs;
  String get response => _response.value;
  @override
  // void onInit() {
  //   fetchEvents();
  //   super.onInit();
  // }
  Future<void> fetchEvents(user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await dotenv.load();
      var response = await http.get(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.user_details?user=$user",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.statusCode);
      var eventsJson = jsonDecode(response.body)['user_details'] as List;
      print(eventsJson);
      userDetail.value =
          eventsJson.map((details) => UserDetails.fromJson(details)).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchfamily(user) async {
    print("scjkbcksjbckjbcjsdabcabc");
    try {
      final prefs = await SharedPreferences.getInstance();

      await dotenv.load();
      var response = await http.get(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.user_api_list.user_details?user=$user",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.statusCode);
      var eventsjsonFamily =
          jsonDecode(response.body)['user_list']['family'] as List;
      var eventsjsonOrg =
          jsonDecode(response.body)['user_list']['organisation'] as List;
      print(eventsjsonFamily);

      print(eventsjsonOrg);
      print('pppppppppppppppppppppppppp');

      userFamily.value = eventsjsonFamily
          .map((details) => FamilyDetails.fromJson(details))
          .toList();
      userOrg.value = eventsjsonOrg
          .map((details) => OrganisationDetails.fromJson(details))
          .toList();

    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future callNotifi(data) async {
    print("fffffffffffffffffffffffffffff");
    print(data);
    try {
      final prefs = await SharedPreferences.getInstance();

      await dotenv.load();
      var response = await http.post(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.call_notification",
        ),
        body: {'data': jsonEncode(data)},
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        print(_response.value);
        print("pppppppdppdpdpdpdpddd");
        print(_response.value);
        Get.back();
        Get.snackbar(
          "Success",
          jsonDecode(response.body)["call_notification"],
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
        if (data["mobile"].length >= 10) {
          await FlutterPhoneDirectCaller.callNumber(data["mobile"].toString());
        }
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
