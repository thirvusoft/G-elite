import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/untils/colors.dart';
import 'package:gelite/untils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:searchfield/searchfield.dart';
import 'package:heroicons/heroicons.dart';
import '../controller/koottamcontroller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final Koottamcontroller kottamcontroller = Get.put(Koottamcontroller());
  final _signupKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _result = false;
  String password = '';
  String confirmPassword = '';
  List koottam = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: IconButton(
              icon: const Icon(
                PhosphorIcons.caret_left,
              ),
              onPressed: () {
                Get.toNamed("/login");
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Sign Up',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _signupKey,
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: firstnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const HeroIcon(
                              HeroIcons.user,
                              size: 15,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.textcolour),
                            ),
                            labelText: "First Name",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.textcolour),
                          ),
                          labelText: "Last Name",
                        ),
                      ))
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: mobilenumberController,
                      onTap: () {
                        setState(() {
                          koottam = kottamcontroller.kottom;
                        });
                      },
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
                    SearchField(
                      controller: kootamController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select Koottam';
                        }
                        if (!koottam.contains(value)) {
                          return 'koottam not found';
                        }
                        return null;
                      },
                      suggestions: koottam
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
                        suffixIcon: const HeroIcon(
                          HeroIcons.userGroup,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Koottam",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailidController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
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
                      controller: dobController,
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
                        dobController.text = date.toString().substring(0, 10);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ADD ADDRESS",
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            color: AppColors.iconcolor,
                            letterSpacing: .5,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SearchField(
                      controller: districtController,
                      // controller: district_list_text,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please select District';
                      //   }
                      //   if (!districts.contains(value)) {
                      //     return 'District not found';
                      //   }
                      //   return null;
                      // },
                      suggestions: koottam
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
                        suffixIcon: const Icon(PhosphorIcons.buildings),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "District",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SearchField(
                      controller: areaController,
                      // controller: district_list_text,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please select District';
                      //   }
                      //   if (!districts.contains(value)) {
                      //     return 'District not found';
                      //   }
                      //   return null;
                      // },
                      suggestions: koottam
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
                        suffixIcon: const Icon(PhosphorIcons.mountains),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Area",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: pincodeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(PhosphorIcons.list_numbers),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: AppColors.textcolour),
                        ),
                        labelText: "Pincode",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: confirmController,
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
                          if (_signupKey.currentState!.validate()) {
                            // Get.toNamed("screen2");
                          }
                        },
                        child: (_result)
                            ? LoadingAnimationWidget.discreteCircle(
                                color: Colors.white,
                                size: 25,
                                secondRingColor: Colors.white,
                              )
                            : const Text('SUBMIT'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )),
          ),
        ));
  }
}
