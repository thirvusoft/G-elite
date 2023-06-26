import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../models/profile.dart';

class Bannerevent extends GetxController {
  var bannerlist = [].obs;

  @override
  void onInit() {
    // bannerList();
    bannerList();
    super.onInit();
  }

  Future bannerList() async {
    print('======================');
    try {
      await dotenv.load();
      var response = await http.get(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.banner_image",
      ));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var bannerImage = jsonDecode(response.body)['message'] as List;
        print(bannerImage);
        print("bannerImage");
        print("bannerImage");
        bannerlist.value =
            bannerImage.map((banner) => Banner.fromJson(banner)).toList();
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
