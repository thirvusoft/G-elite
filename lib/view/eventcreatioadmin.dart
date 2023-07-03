import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/eventcontroller.dart';
import '../controller/koottamcontroller.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';

class Eventsadmin extends StatefulWidget {
  const Eventsadmin({super.key});

  @override
  State<Eventsadmin> createState() => _EventsadminState();
}

class _EventsadminState extends State<Eventsadmin> {
  final Koottamcontroller kottamcontroller = Get.put(Koottamcontroller());
  final Eventcontroller eventcontroller = Get.put(Eventcontroller());
  final _eventKey = GlobalKey<FormState>();
  late Timer timer;

  List user = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(PhosphorIcons.caret_left_bold),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              ' Event Creation',
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                    color: AppColors.scaffoldBackgroundColor,
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        body: Form(
            key: _eventKey,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextFormField(
                    controller: startdataController,
                    textInputAction: TextInputAction.next,
                    validator: (x) {
                      if (x!.isEmpty) {
                        return " Date can't be empty";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(PhosphorIcons.calendar),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.textcolour),
                      ),
                      labelText: "Starts on *",
                    ),
                    style: const TextStyle(),
                    readOnly: true,
                    onTap: () async {
                      setState(() {
                        user = kottamcontroller.user;
                      });

                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2101),
                        helpText: 'Select a date',
                        cancelText: 'Cancel',
                        confirmText: 'Ok',
                      );
                      startdataController.text =
                          date.toString().substring(0, 10);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: enddataController,
                    textInputAction: TextInputAction.next,
                    validator: (x) {
                      if (x!.isEmpty) {
                        return " Date can't be empty";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(PhosphorIcons.calendar),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.textcolour),
                      ),
                      labelText: "Ends on *",
                    ),
                    style: const TextStyle(),
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2101),
                        helpText: 'Select a date',
                        cancelText: 'Cancel',
                        confirmText: 'Ok',
                      );
                      enddataController.text = date.toString().substring(0, 10);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: subController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select subject';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        PhosphorIcons.pen,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.textcolour),
                      ),
                      labelText: "Subject",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SearchField(
                    controller: uerController,
                    validator: (value) {
                      if (userlist.isEmpty) {
                        return 'Please select user';
                      }

                      return null;
                    },
                    suggestions: user
                        .map((String) => SearchFieldListItem(String))
                        .toList(),
                    suggestionState: Suggestion.expand,
                    textInputAction: TextInputAction.next,
                    marginColor: Colors.white,
                    searchStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    onSuggestionTap: (x) {
                      FocusScope.of(context).unfocus();
                    },
                    searchInputDecoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            bool isDuplicate = false;

                            var name = {};
                            if (uerController.text.isNotEmpty) {
                              name["username"] = uerController.text.trim();
                              print(uerController.text.trim());
                              setState(() {
                                for (var user in userlist) {
                                  if (user['username'] == uerController.text) {
                                    isDuplicate = true;
                                    break;
                                  }
                                }
                                if (!isDuplicate) {
                                  userlist.add(name);
                                  uerController.clear();
                                }
                              });
                            }
                          },
                          icon: const HeroIcon(
                            HeroIcons.plusCircle,
                            size: 23,
                          )),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.textcolour),
                      ),
                      labelText: "User *",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height /
                        7 *
                        userlist.length /
                        1.5,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 3),
                      itemCount: userlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Text(
                                      userlist[index]["username"].trim(),
                                      style: const TextStyle(fontSize: 11.0))),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          print(index);
                                          userlist.removeAt(index);
                                        });
                                      },
                                      icon: const HeroIcon(
                                        HeroIcons.xMark,
                                        size: 12,
                                      ))),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 343,
                    height: 59,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                        backgroundColor: AppColors.primaryColor,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () async {
                        if (_eventKey.currentState!.validate()) {
                          final prefs = await SharedPreferences.getInstance();
                          FocusScope.of(context).unfocus();
                          print(prefs.getString('full_name'));
                          kottamcontroller.eventCreations(json.encode({
                            "user": prefs.getString('full_name'),
                            "subject": subController.text,
                            "starts_on": startdataController.text,
                            "ends_on": enddataController.text,
                            "participant": userlist,
                          }));
                        }
                        timer = Timer(const Duration(seconds: 2), () {
                          subController.clear();
                          startdataController.clear();
                          enddataController.clear();
                          setState(() {
                            userlist.clear();
                          });
                        });
                      },
                      child:
                          //  (_result)
                          //     ? LoadingAnimationWidget.discreteCircle(
                          //         color: Colors.white,
                          //         size: 25,
                          //         secondRingColor: Colors.white,
                          //       )
                          //     :
                          const Text('SUBMIT'),
                    ),
                  ),
                ]))));
  }
}
