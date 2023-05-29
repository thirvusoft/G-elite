import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:gelite/models/uselist.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserController extends GetxController {
  var userlist = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    await dotenv.load();
    final prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.get(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.user_list?user=${prefs.getString('full_name')}"),
      );
      var eventsJson = jsonDecode(response.body)['user_list'] as List;
      isLoading.value = true;
      userlist.value = eventsJson.map((user) => User.fromJson(user)).toList();
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
