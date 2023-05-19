import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/controller/filecontroller.dart';
import 'package:gelite/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/colors.dart';

class MultipleFilepickerScreen extends StatefulWidget {
  const MultipleFilepickerScreen({super.key});

  @override
  State<MultipleFilepickerScreen> createState() =>
      _MultipleFilepickerScreenState();
}

class _MultipleFilepickerScreenState extends State<MultipleFilepickerScreen> {
  final FilePickerController filepi = Get.put(FilePickerController());
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
            'Upload',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                color: AppColors.textcolour,
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
                        filepi.pickFiles();
                        determinateIndicator();
                        setState(() {
                          value = 0.0;
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          height: 198,
                          color: const Color(0xffffffff),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Icon(
                                PhosphorIcons.cloud_arrow_up_light,
                                color: Color(0xFF2B3467),
                                size: 49,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Drag & drop files ",
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Supported formates: JPEG, PNG,  PDF",
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff676767),
                                      letterSpacing: .1,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ))),
                )),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Uploaded",
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: filepi.selectedFiles.length,
                  itemBuilder: (context, index) {
                    String file = filepi.selectedFiles[index];
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 11,
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 325,
                                  // height: 20,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: LinearProgressIndicator(
                                        backgroundColor:
                                            const Color(0xffe8effc),
                                        color: AppColors.iconcolor,
                                        value: value,
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
                                    filepi.deleteFiles(
                                        filepi.selectedFiles[index]);
                                  },
                                ),
                              ))),
                    );
                  },
                ),
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
                  setState(() {
                    upload = true;
                  });
                  filepi.uploadFiles();
                  bool allFilesUploaded = await filepi.uploadFiles();
                  if (allFilesUploaded) {
                    setState(() {
                      upload = false;
                    });
                  }
                },
                child: (upload)
                    ? LoadingAnimationWidget.prograssiveDots(
                        color: Colors.white,
                        size: 35,
                      )
                    : const Text('UPLOAD FILES'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (value == 2) {
          timer.cancel();
        } else {
          value = value + 0.1;
        }
      });
    });
  }
}
