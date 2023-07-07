import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/bannercontroller.dart';
import '../utils/colors.dart';

class Businessdetails extends StatelessWidget {
  Businessdetails({super.key});

  @override
  final Bannerevent businesscard = Get.put(Bannerevent());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            businesscard.title.toString(),
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: AppColors.scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        body: const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The company PRIMO HOLIDAYS is a brand new Tours and Travels Agency in Tirupur, India. Our brand is new, but our team has more than 15 years of experience in the Tours and Travels field.",
              ),
              SizedBox(height: 10),
              Text(
                "Already we have 6500+ well-satisfied customers and the counting is going on. Our customer list says we are one of the most trusted travel agencies in Tirupur. With our customer support and blessings, we are traveling to the next level.",
              ),
              SizedBox(height: 10),
              Text(
                "We provide worldwide Tours and Travels, preplanned tour packages, ticket bookings, and hotel bookings. Additionally, we offer value-added services such as travel insurance, passport & visa support, forex services, international SIM cards, and all travel solutions for travelers.",
              ),
              SizedBox(height: 10),
              Text(
                "Our package tours include international tour packages, domestic tour packages, international honeymoon packages, domestic honeymoon packages, luxury holiday packages, cruise trip packages, and spiritual packages.",
              ),
            ],
          ),
        )));
  }
}
