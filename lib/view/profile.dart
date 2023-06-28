import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/profilecontroller.dart';
import '../utils/colors.dart';
import '../widgets/popup.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController profilecontroller = Get.put(ProfileController());
  bool _isHidden = true;
  final _profileKey = GlobalKey<FormState>();
  bool _result = false;
  String password = '';
  String mobileNo = "";
  String dob = "";
  String bloodGroup = "";
  String aadharNo = "";
  String confirmPassword = '';

  get up => null;
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
                Get.back();
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
            height: 125,
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
                                "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg"),
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
                  child: Obx(
                    () => SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                          itemCount: profilecontroller.profileDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            final profile =
                                profilecontroller.profileDetails[index];
                            mobileNo = profile.mobileNo;
                            dob = profile.birthDate;
                            bloodGroup = profile.bloodGroup;
                            aadharNo = profile.aadharNo;
                            return Column(
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: profileemailidController,
                                  decoration: InputDecoration(
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.envelope,
                                      size: 20,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    labelText: profile.aadharNo.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: profilemobilnumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.phone,
                                      size: 20,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    labelText: profile.mobileNo,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: profiledobController,
                                  textInputAction: TextInputAction.next,
                                  validator: (x) {
                                    if (x!.isEmpty) {
                                      return " Date can't be empty";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(PhosphorIcons.calendar),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    labelText: (profile.birthDate == " ")
                                        ? "D.O.B"
                                        : profile.birthDate,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: profilebloodController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email address';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.envelope,
                                      size: 20,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    labelText: (profile.bloodGroup == "")
                                        ? "D.O.B"
                                        : "Blood Group",
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  obscureText: _isHidden,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    labelText: "New Password",
                                    prefixIcon: IconButton(
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.textcolour),
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Icon((_isHidden)
                                          ? PhosphorIcons.eye
                                          : PhosphorIcons.eye_slash),
                                      onPressed: () {
                                        setState(() {
                                          _isHidden = !_isHidden;
                                        });
                                      },
                                    ),
                                    labelText: "Confirm Password",
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      print("dddddd");
                                      showPopup(context);

                                      // showPopup(context);
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor:
                                              AppColors.backgroundColor,
                                          child: Icon(
                                            PhosphorIcons.sign_out_light,
                                            color: AppColors.iconcolor,
                                          )),
                                      title: Text(
                                        '  Logout  ',
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                              color: AppColors.iconcolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )),
                                const Divider(
                                  thickness: 1,
                                  color: Color(0xff737373),
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    onPressed: () {
                                      profilecontroller
                                          .profileUpdation(jsonEncode({
                                        "user": "Vignesh M",
                                        "birth_date":
                                            profiledobController.text.isEmpty
                                                ? dob
                                                : profiledobController.text,
                                        "mobile_no":
                                            profilemobilnumberController
                                                    .text.isEmpty
                                                ? mobileNo
                                                : profilemobilnumberController
                                                    .text,
                                        "blood_group":
                                            profilebloodController.text.isEmpty
                                                ? bloodGroup
                                                : profilebloodController.text,
                                        "password": "admin@123",
                                        "aadhar_no": profileemailidController
                                                .text.isEmpty
                                            ? aadharNo
                                            : profileemailidController.text
                                      }));
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
                            );
                          }),
                    ),
                  )))
        ]));
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupWidget();
      },
    );
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
                              onPressed: () {
                                print(profilecontroller.profileDetails);
                              },
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
