import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/notification.dart";

class Notificationcontroller extends GetxController {
  var notificationLists = [].obs;

  @override
  void onInit() {
    notifi();
    super.onInit();
  }

  Future notifi() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await dotenv.load();
      prefs.getString('full_name');
      var response = await http.post(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.notification_list?user=${prefs.getString('full_name')}",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.body);
      print(response.statusCode);
      var eventsJson = jsonDecode(response.body)['call_notification'] as List;
      print(eventsJson);
      notificationLists.value =
          eventsJson.map((event) => CallNotification.fromJson(event)).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
