import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/filecontroller.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';
import '../widgets/button.dart';

class Bannerupload extends StatefulWidget {
  const Bannerupload({super.key});

  @override
  State<Bannerupload> createState() => _BanneruploadState();
}

class _BanneruploadState extends State<Bannerupload> {
  @override
  final bannerkey = GlobalKey<FormState>();
  final FilePickerController filecontroller = Get.put(FilePickerController());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              PhosphorIcons.caret_left,
            ),
          ),
          title: Text(
            'Banner',
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  color: AppColors.scaffoldBackgroundColor,
                  letterSpacing: .5,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Form(
            key: bannerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: tittleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter tittle';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    suffixIcon: const Icon(PhosphorIcons.pencil_simple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: AppColors.textcolour),
                    ),
                    labelText: "Tittle *",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter offer';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    suffixIcon: const Icon(PhosphorIcons.medal),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: AppColors.textcolour),
                    ),
                    labelText: "offer *",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: messageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    suffixIcon: const Icon(PhosphorIcons.list_dashes),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: AppColors.textcolour),
                    ),
                    labelText: "Description *",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    color: const Color(0xFF2B3467),
                    strokeWidth: 2,
                    strokeCap: StrokeCap.round,
                    dashPattern: const [
                      5,
                      5,
                      5,
                    ],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      child: GestureDetector(
                          onTap: () {
                            filecontroller.pickFiles();
                          },
                          child: Container(
                              width: 333,
                              height: 75,
                              color: AppColors.backgroundColor,
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    PhosphorIcons.cloud_arrow_up_light,
                                    color: Color(0xFF2B3467),
                                    size: 30,
                                  ),
                                  Text("Click to upload")
                                ],
                              ))),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                    child: ListView.builder(
                      itemCount: filecontroller.selectedFiles.length,
                      itemBuilder: (context, index) {
                        String file = filecontroller.selectedFiles[index];
                        File files = File(filecontroller.selectedFiles[index]);
                        return SizedBox(
                          // height: MediaQuery.of(context).size.height / 11,
                          child: Card(
                              semanticContainer: true,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                  leading: Image.file(files),
                                  title: Text(
                                    file.split("/").last,
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .1,
                                          fontSize: 15),
                                    ),
                                  ),
                                  subtitle: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: 325,
                                      // height: 20,
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            backgroundColor:
                                                const Color(0xffe8effc),
                                            color: AppColors.iconcolor,
                                            value: 1,
                                            minHeight: 7,
                                          ))),
                                  trailing: CircleAvatar(
                                    backgroundColor: AppColors.backgroundColor,
                                    child: IconButton(
                                      icon: Icon(
                                        PhosphorIcons.trash,
                                        color: AppColors.iconcolor,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        filecontroller.deleteFiles(
                                            filecontroller
                                                .selectedFiles[index]);
                                      },
                                    ),
                                  ))),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Elevatebutton(
                  formKey: bannerkey,
                  name: 'Submit',
                  onPressed: () {
                    filecontroller.banner({
                      "title": tittleController.text,
                      "description": descriptionController.text,
                      "offer": messageController.text
                    });
                    Timer(const Duration(seconds: 2), () {
                      tittleController.clear();
                      descriptionController.clear();
                      messageController.clear();
                    });
                  },
                )
              ],
            ),
          ),
        )));
  }
}
