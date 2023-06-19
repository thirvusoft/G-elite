import 'dart:ffi';

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'button.dart';

class Bottomsheet extends StatelessWidget {
  final String fullName;

  const Bottomsheet({Key? key, required this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Send Message",
            Stack(children: [
              const SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Center(
                    child: Text(
                  "Send Message",
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1.0,
                  ),
                )),
              ),
              Positioned(
                  left: 5,
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    child: IconButton(
                        icon:
                            Icon(Icons.arrow_back, color: AppColors.iconcolor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ))
            ]),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Enter Message'),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Elevatebutton(
              name: 'Send',
              onPressed: () {},
            )
          ],
        ),
      ),
    ));
  }
}
