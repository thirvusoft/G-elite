import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
import 'package:http/http.dart' as http;
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../models/userdetails.dart";

class Userdetailscontroller extends GetxController {
  var userDetail = [].obs;

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

  Future callNotifi(data) async {
   print(data);
  int mobileNo = int.parse(
    data['d']['mobileNo'][1].toString());
  print("decxrtvy5tr");
    print(mobileNo);
  //  List o=[];
  //  o.add(data);
   
   
   
    try {
      final prefs = await SharedPreferences.getInstance();

      await dotenv.load();
      var response = await http.post(
        Uri.parse(
          "${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.call_notification",
        ),
        body: {'data': data},
        headers: {
          "Authorization": prefs.getString('token').toString(),
        },
      );

     print(response.statusCode);
     print(response.body);
     if(response.statusCode==200){
      
          // if (user.mobileNo.length >= 10) {
          //     await FlutterPhoneDirectCaller.callNumber(user.mobileNo);
          //   }
     }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
