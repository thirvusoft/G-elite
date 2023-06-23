import 'package:flutter/material.dart';
import 'package:gelite/utils/helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/userdetailcontroller.dart';
import '../utils/colors.dart';
import 'button.dart';

class Bottomsheet extends StatefulWidget {
  final String fullName;
  final String mobileNo;

  Bottomsheet({Key? key, required this.fullName, required this.mobileNo})
      : super(key: key);

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final bootmsheetkey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();
  var message = "";
  var email = "";
  final Userdetailscontroller eventcontroller =
      Get.put(Userdetailscontroller());

  @override
  void initState() {
    super.initState();
    Future(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        email = prefs.getString('doc_name')!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: bootmsheetkey,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        message = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A message should not be empty!';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Message'),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Elevatebutton(
              name: 'Send',
              value: {
                "user": widget.fullName,
                "mobile": widget.mobileNo,
                "description": message,
                "email": email
              },
              onPressed: () => eventcontroller.callNotifi({
                "user": widget.fullName,
                "mobile": widget.mobileNo,
                "description": message,
                "email": email
              }),
              formKey: bootmsheetkey,
            )
          ],
        ),
      ),
    ));
  }
}
