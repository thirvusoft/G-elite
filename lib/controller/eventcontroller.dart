import "dart:convert";

import 'package:http/http.dart' as http;

import "package:dio/dio.dart";
import "package:get/state_manager.dart";

import "../models/event.dart";

class Eventcontroller extends GetxController {
  var eventList = [].obs;
  var eventLists = [].obs;
  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      var response = await http.get(
        Uri.parse(
          "https://events.thirvusoft.co.in/api/method/thirvu_event.custom.py.api.event_list?user=Test",
        ),
      );
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
}
