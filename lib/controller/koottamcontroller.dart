import "dart:convert";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "../models/event.dart";

class Koottamcontroller extends GetxController {
  var kottom = [].obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      var response = await http.get(
        Uri.parse(
          "https://events.thirvusoft.co.in/api/method/thirvu_event.custom.py.api.kootam",
        ),
      );
      var kottamJson = jsonDecode(response.body)['Kottam'] as List;
      kottom.value = kottamJson.map((k) => k.toString()).toList();
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
