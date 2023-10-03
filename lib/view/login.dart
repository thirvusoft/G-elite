import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gelite/controller/koottamcontroller.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/bannercontroller.dart';
import '../controller/eventcontroller.dart';
import '../utils/helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;
  bool _result = false;
  int activePage = 1;
  final _formKey = GlobalKey<FormState>();
  final Koottamcontroller kottamcontroller = Get.put(Koottamcontroller());
  // final Bannerevent bannerevent = Get.find<Bannerevent>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Obx(
                  //   () => SizedBox(
                  //     height: (MediaQuery.of(context).size.height) / 3,
                  //     child: CarouselSlider.builder(
                  //       itemCount: bannerevent.bannerlist.length,
                  //       itemBuilder: (BuildContext context, int itemIndex,
                  //           int pageViewIndex) {
                  //         var banner = bannerevent.bannerlist[itemIndex];
                  //         if (bannerevent.bannerlist.isEmpty) {
                  //           return Container();
                  //         } else {
                  //           return Banner(
                  //             message: banner.offerMsg,
                  //             location: BannerLocation.topStart,
                  //             color: Colors.red,
                  //             child: Container(
                  //               color: Colors.white,
                  //               height: 220,
                  //               child: Padding(
                  //                 padding:
                  //                     const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  //                 child: Column(
                  //                   children: <Widget>[
                  //                     SizedBox(
                  //                       height: (MediaQuery.of(context)
                  //                               .size
                  //                               .height) /
                  //                           8,
                  //                       width:
                  //                           (MediaQuery.of(context).size.width),
                  //                       child: Image.network(
                  //                         banner.image,
                  //                         fit: BoxFit.fill,
                  //                         loadingBuilder: (BuildContext context,
                  //                             Widget child,
                  //                             ImageChunkEvent?
                  //                                 loadingProgress) {
                  //                           if (loadingProgress == null) {
                  //                             return child;
                  //                           }
                  //                           return Center(
                  //                             child: CircularProgressIndicator(
                  //                               value: loadingProgress
                  //                                           .expectedTotalBytes !=
                  //                                       null
                  //                                   ? loadingProgress
                  //                                           .cumulativeBytesLoaded /
                  //                                       loadingProgress
                  //                                           .expectedTotalBytes!
                  //                                   : null,
                  //                             ),
                  //                           );
                  //                         },
                  //                       ),
                  //                     ),
                  //                     const SizedBox(height: 5),
                  //                     Text(
                  //                       banner.tittle,
                  //                       style: const TextStyle(
                  //                           color: Colors.green,
                  //                           fontSize: 20,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                     const SizedBox(
                  //                       height: 2,
                  //                     ),
                  //                     Text(
                  //                       banner.description,
                  //                       softWrap: false,
                  //                       maxLines: 3,
                  //                       overflow: TextOverflow.ellipsis,
                  //                       style: const TextStyle(
                  //                           color: Colors.green,
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //       },
                  //       options: CarouselOptions(
                  //         onPageChanged: (index, reason) {
                  //           setState(() {
                  //             activePage = index;
                  //           });
                  //         },
                  //         height: (MediaQuery.of(context).size.height) / 3,
                  //         aspectRatio: 16 / 9,
                  //         viewportFraction: 0.8,
                  //         initialPage: 1,
                  //         enableInfiniteScroll: true,
                  //         reverse: false,
                  //         autoPlay: true,
                  //         autoPlayInterval: const Duration(seconds: 5),
                  //         autoPlayAnimationDuration:
                  //             const Duration(milliseconds: 1000),
                  //         autoPlayCurve: Curves.linear,
                  //         enlargeCenterPage: true,
                  //         enlargeFactor: 0.3,
                  //         scrollDirection: Axis.horizontal,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: indicators(
                  //         bannerevent.bannerlist.length, activePage)),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    backgroundImage: const AssetImage(
                      'assets/logo.png',
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text("Login into G-elite",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                        ),
                      )),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/logo.png',
                  //     height: 250,
                  //     width: 250,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
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
                        print(kottamcontroller.kottom.value);
                        if (_formKey.currentState!.validate()) {
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
    print("peppepepppepepepepe");

    // await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio();
    await dotenv.load();
    print(mobilenumber);
    print(phone);
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
      print(response.statusCode);
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
        if (value["roll"] == "super_admin") {
          print("pppppppppppppppppppppppppppppppppp");
          Get.offAllNamed("/landingPage1");
        } else {
          Get.offAllNamed("/LandingPage");
        }
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
        await prefs.setString('doc_name', value["doc_name"]);
      }
    } catch (e) {
      // Handle error
    }
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color:
                currentIndex == index ? AppColors.primaryColor : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
