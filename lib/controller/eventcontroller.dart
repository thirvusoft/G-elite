import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../models/event.dart";

class Eventcontroller extends GetxController {
  var eventList = [].obs;
  var eventLists = [].obs;
  var eventListsadmin = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    // bannerList();
    fetchEvents();
    fetchEventsadmin();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await dotenv.load();
      prefs.getString('full_name');
      var response = await http.get(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.event_list?user=${prefs.getString('full_name')}",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.statusCode);
      var eventsJson = jsonDecode(response.body)['today'] as List;
      var eventsJsons = jsonDecode(response.body)['upcoming'] as List;
      eventList.value =
          eventsJson.map((event) => Event.fromJson(event)).toList();
      eventLists.value =
          eventsJsons.map((event) => Events.fromJson(event)).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchEventsadmin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await dotenv.load();
      prefs.getString('full_name');
      var response = await http.get(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.event_list_admin?user=${prefs.getString('full_name')}",
        ),
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );
      print(response.statusCode);
      print(response.body);
      var eventsJson = jsonDecode(response.body)['event'] as List;
      isLoading.value = true;
      eventListsadmin.value =
          eventsJson.map((event) => Eventadmin.fromJson(event)).toList();
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
