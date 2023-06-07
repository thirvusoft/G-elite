import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelite/controller/koottamcontroller.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';
import '../widgets/button.dart';

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
              CarouselSlider.builder(
                itemCount: 15,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Banner(
                  message: "20% off !!",
                  location: BannerLocation.bottomStart,
                  color: Colors.red,
                  child: Container(
                    color: Colors.green[100],
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        children: <Widget>[
                          Image.network(
                              'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190806131525/forkPython.jpg'),
                          const SizedBox(height: 10),
                          const Text(
                            'GeeksforGeeks',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Fork Python Course',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 400,
                  width: 310.45,
                ),
              ),
              TextFormField(
                maxLength: 10,
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
              // Elevatebutton(
              //   formKey:_formKey,
              //   name:"login",onPressed:(){

              // }),
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
                  onPressed: () async {
                    // const number = '08592119XXXX'; //set the number here
                    // bool? res =
                    //     await FlutterPhoneDirectCaller.callNumber(number);

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
            ],
          )),
    ))));
  }

  Future login(String mobilenumber, String phone) async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio();
    await dotenv.load();

    try {
      final response = await dio.post(
        '${dotenv.env['API_URL']}/api/method/g_elite_admin.g_elite_admin.Api.api_list.login',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'email': mobilenumber,
          'password': phone,
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        var value;
        setState(() {
          _result = false;
          value = response.data;
        });
        print(value["full_name"]);

        print("lllllllllllllllllllllll");
        print(prefs.getString('kottam'));

        Fluttertoast.showToast(
            msg: value["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[50],
            textColor: AppColors.primaryColor,
            fontSize: 16.0);
        await prefs.setString('token', value["token"]);
        await prefs.setString('full_name', value["full_name"]);
        await prefs.setString('kottam', value["kottam"]);
        await prefs.setString('roll', value["roll"]);
        if (value["roll"] == "super_admin") {
          Get.offAllNamed("/landingPage1");
        } else {
          Get.offAllNamed("/LandingPage");
        }
      }
    } catch (e) {
      // Handle error
    }
  }
}
