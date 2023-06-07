import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../models/userdetails.dart";

class Userdetailscontroller extends GetxController {
  var userDetail = [].obs;
  // @override
  // void onInit() {
  //   fetchEvents();
  //   super.onInit();
  // }

  Future<void> fetchEvents(user) async {
    print("hvhvhvhvhvhhvvhh");
    print(user);
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.getString('token').toString());

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
}
