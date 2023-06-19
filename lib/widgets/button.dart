import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/userdetailcontroller.dart';
import '../utils/colors.dart';

class Elevatebutton extends StatelessWidget {
  final Userdetailscontroller eventcontroller =
      Get.put(Userdetailscontroller());
      
  // const Elevatebutton({super.key});
  final String name;
  final Function onPressed;
  var value;
  // final GlobalKey<FormState> formKey;
   Elevatebutton({
    super.key,
    // required this.formKey,
    required this.name,
    required this.onPressed,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 59,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        onPressed: () async {
          print(value);
          print("%%%%%%%%%%%");
          eventcontroller.callNotifi(
            jsonEncode(value),
            );
          // if (formKey.currentState!.validate()) {}
        },
        child:

            // (_result)
            //     ? LoadingAnimationWidget.discreteCircle(
            //         color: Colors.white,
            //         size: 25,
            //         secondRingColor: Colors.white,
            //       )
            //     :

            Text(name.toString()),
      ),
    );
  }
}
