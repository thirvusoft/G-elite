import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Koottamcontroller extends GetxController {
  var kottom = [].obs;
  var district = [].obs;
  var area = [].obs;

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
}
