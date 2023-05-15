
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelite/controller/koottamcontroller.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;
  bool _result = false;
  final _formKey = GlobalKey<FormState>();
  final Koottamcontroller kottamcontroller = Get.put(Koottamcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 400,
                  width: 310.45,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: mobilerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  return null;
                },
                decoration: InputDecoration(
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
                controller: passController,
                obscureText: _isHidden,
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
                  labelText: "Password",
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
              Padding(
                padding: const EdgeInsets.only(left: 200, top: 7),
                child: GestureDetector(
                    onTap: (() {}), child: const Text("Forget password ?")),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
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
                  ),
                  onPressed: () {
                    print(kottamcontroller.kottom.value);
                    if (_formKey.currentState!.validate()) {
                      // Get.toNamed("screen2");
                      setState(() {
                        _result = true;
                      });
                      login(mobilerController.text, passController.text);
                    }
                  },
                  child: (_result)
                      ? LoadingAnimationWidget.discreteCircle(
                          color: Colors.white,
                          size: 25,
                          secondRingColor: Colors.white,
                        )
                      : const Text('LOGIN'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: AppColors.textcolour,
                          letterSpacing: .5,
                          fontSize: 20),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: " Sign up",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: AppColors.primaryColor,
                              letterSpacing: .5,
                              fontSize: 20),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed("/signup");
                          },
                      )
                    ]),
              ),
            ],
          )),
    ))));
  }

  Future login(String mobilenumber, String phone) async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio();
    try {
      final response = await dio.post(
        'https://events.thirvusoft.co.in/api/method/thirvu_event.custom.py.api.login',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'email': mobilenumber,
          'password': phone,
        },
      );
      if (response.statusCode == 200) {
        var value;
        setState(() {
          _result = false;
          value = response.data;
        });
        await prefs.setString('token', value["token"]);
        await prefs.setString('token', value["full_name"]);

        Fluttertoast.showToast(
            msg: value["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[50],
            textColor: AppColors.primaryColor,
            fontSize: 16.0);
        Get.toNamed("/LandingPage");
      }
    } catch (e) {
      // Handle error
    }
  }
}
