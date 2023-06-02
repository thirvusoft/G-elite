import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupWidget extends StatefulWidget {
  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text(
        'Logout',
      ),
      content: const Text(
        'Are You Sure You Want\n to Logout?',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Get.back();
            }),
        const SizedBox(
          width: 30,
        ),
        ElevatedButton(
          child: const Text(
            'Yes, Logout',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.clear();
            Get.offAllNamed("/login");
          },
        ),
      ],
    );
  }
}
