import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/eventcontroller.dart';

TextEditingController passController = TextEditingController();
TextEditingController mobilerController = TextEditingController();
//signup
TextEditingController firstnameController = TextEditingController();
TextEditingController lastnameController = TextEditingController();
TextEditingController mobilenumberController = TextEditingController();
TextEditingController kootamController = TextEditingController();
TextEditingController emailidController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController districtController = TextEditingController();
TextEditingController areaController = TextEditingController();
TextEditingController pincodeController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
TextEditingController landmarkController = TextEditingController();
//profile
TextEditingController profileemailidController = TextEditingController();
TextEditingController profilemobilnumberController = TextEditingController();
TextEditingController profiledobController = TextEditingController();
TextEditingController profilebloodController = TextEditingController();
TextEditingController profilepasswordController = TextEditingController();
TextEditingController profileconfirmController = TextEditingController();

double value = 0.0;
bool upload = false;

//login
var kootam = "";
var fulname = "";
var currentIndex = 0;
Eventcontroller eventcontroller = Get.put(Eventcontroller());
var eventcode = "";
