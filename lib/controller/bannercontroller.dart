import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../models/profile.dart';

class Bannerevent extends GetxController {
  var bannerlist = [].obs;
  var businesscard_ = [].obs;
  var isLoading = false.obs;
  var title = "".obs;

  List businessList = [
    {
      'Option 1': {
        'name': 'Wingstravel Lines',
        'imageUrl':
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1025&q=80',
        'description':
            'We, Wings Travel Lines, are a leading IATA travel agency operating in Tamil Nadu. We are a team of experienced professionals with years of experience in the industry. Our motivated team works with you to organize your events anywhere in the world and create customized and innovative travel packages according to your needs.',
      },
    },
    {
      'Option 2': {
        'name': 'PRIMO HOLIDAYS',
        'imageUrl':
            'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c2hvcHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
        'description':
            'PRIMO HOLIDAYS is a brand new Tours and Travels Agency in Tirupur, India. Although our brand is new, our team members have more than 15 years of experience in the Tours and Travels field. We already have 6500+ satisfied customers and the number is growing. Our customer list speaks for itself, making us one of the most trusted travel agencies in Tirupur. With the support of our customers and blessings, we are taking our travel agency to the next level.',
      },
    },
    {
      'Option 3': {
        'name': 'POPPYS TOURS PRIVATE LIMITED',
        'imageUrl':
            'https://images.unsplash.com/photo-1600525717297-36bae8c1baa9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
        'description':
            'POPPYS TOURS PRIVATE LIMITED is a leading travel agency operating in Tamil Nadu. We are experienced professionals with many years of experience in the industry.',
      },
    },
  ];

  @override
  void onInit() {
    // bannerList();
    // bannerList();
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

        bannerlist.value =
            bannerImage.map((banner) => Banner.fromJson(banner)).toList();
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  updatelist(option) async {
    businesscard_.clear();
    isLoading.value = true;

    for (Map<String, dynamic> item in businessList) {
      if (option == "Option 1") {
        if (item['Option 1'] != null) {
          businesscard_.add(item['Option 1']);
          title.value = item['Option 1']['name'];
          await Future.delayed(const Duration(seconds: 2));
          isLoading.value = false;
        }
      } else if (option == "Option 2") {
        if (item['Option 2'] != null) {
          isLoading.value = true;
          businesscard_.add(item['Option 2']);
          title.value = item['Option 2']['name'];
          await Future.delayed(const Duration(seconds: 2));
          isLoading.value = false;
        }
      } else if (option == "Option 3") {
        if (item['Option 3'] != null) {
          isLoading.value = true;
          businesscard_.add(item['Option 3']);
          title.value = item['Option 3']['name'];
          await Future.delayed(const Duration(seconds: 2));
          isLoading.value = false;
        }
      }
    }
  }
}
