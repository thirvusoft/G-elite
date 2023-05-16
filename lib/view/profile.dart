import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isHidden = true;
  final _profileKey = GlobalKey<FormState>();
  bool _result = false;
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: IconButton(
              icon: const Icon(
                PhosphorIcons.caret_left,
              ),
              onPressed: () {
                Get.toNamed("/Homepage");
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'My Profile',
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
        body: ListView(children: [
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 150,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 125,
                    child: Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.0,
                              style: BorderStyle.solid),
                          image: const DecorationImage(
                            // fit: BoxFit.cover,
                            matchTextDirection: true,
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaYXAEbhjwPG22qOBDO-bBDC8bUL6AEwkex1zes2-59vOp0qOk-svdY3k7TwtD6xy6cOU&usqp=CAU"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height / 90,
                        // left: 40.0,
                        right: MediaQuery.of(context).size.width * 0.31,
                        child: InkWell(
                          onTap: () {
                            showMyModalBottomSheet(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.iconcolor,
                            child: const Icon(
                              PhosphorIcons.camera,
                              color: Colors.white,
                              size: 28.0,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ]),
          ),
          Form(
              key: _profileKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profileemailidController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        RegExp regex = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: const HeroIcon(
                          HeroIcons.envelope,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Email Address",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profilemobilnumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: const HeroIcon(
                          HeroIcons.phone,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Mobile Number",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profiledobController,
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
                        labelText: "D.O.B",
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
                        profiledobController.text =
                            date.toString().substring(0, 10);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profilebloodController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: const HeroIcon(
                          HeroIcons.envelope,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Blood Group",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profilepasswordController,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "New Password",
                        suffixIcon: IconButton(
                          icon: Icon((_isHidden)
                              ? PhosphorIcons.eye
                              : PhosphorIcons.eye_slash),
                          onPressed: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: profileconfirmController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter password';
                        }
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Confirm Password",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 343,
                      height: 59,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                          backgroundColor: AppColors.primaryColor,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          if (_profileKey.currentState!.validate()) {
                            // Get.toNamed("screen2");
                          }
                        },
                        child: (_result)
                            ? LoadingAnimationWidget.discreteCircle(
                                color: Colors.white,
                                size: 25,
                                secondRingColor: Colors.white,
                              )
                            : const Text('SAVE'),
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }

  void showMyModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Upload New',
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: AppColors.primaryColor,
                          letterSpacing: .1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.backgroundColor,
                            radius: 45,
                            child: IconButton(
                              icon: HeroIcon(
                                HeroIcons.camera,
                                size: 25,
                                color: AppColors.iconcolor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Text(
                            'Capture',
                            style: TextStyle(
                              color: AppColors.textcolour,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.backgroundColor,
                            radius: 45,
                            child: IconButton(
                              icon: HeroIcon(
                                HeroIcons.photo,
                                size: 25,
                                color: AppColors.iconcolor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              color: AppColors.textcolour,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
