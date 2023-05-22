import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:gelite/models/uselist.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";

class UserController extends GetxController {
  var userlist = [].obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    await dotenv.load();
    print(dotenv.env['API_URL']);
    try {
      var response = await http.get(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.user_list"),
      );
      var eventsJson = jsonDecode(response.body)['user_list'] as List;
      print(eventsJson);
      userlist.value = eventsJson.map((user) => User.fromJson(user)).toList();
      userlist.refresh();
      print(userlist.value);
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
