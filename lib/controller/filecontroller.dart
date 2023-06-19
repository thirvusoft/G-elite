import "dart:io";
import "package:dio/dio.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_phosphor_icons/flutter_phosphor_icons.dart";
import 'package:get/get.dart' as GET;
import "package:get/get_navigation/src/snackbar/snackbar.dart";
import "package:get/state_manager.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../utils/colors.dart";

class FilePickerController extends GetxController {
  List selectedFiles = [].obs;

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );

    if (result != null) {
      selectedFiles.assignAll(result.paths);
    } else {
      // User canceled the file picking.
    }
  }

  void deleteFiles(index) {
    selectedFiles.remove(index);
  }

  Future<bool> uploadFiles() async {
    print("dddddddddddddd");
    final prefs = await SharedPreferences.getInstance();
    await dotenv.load();

    Dio dio = Dio();
    List<int> j = [];

    try {
      for (int i = 0; i < selectedFiles.length; i++) {
        String filePath = selectedFiles[i] as String;

        File file = File(filePath);
        String filename = file.path.split("/").last;

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(file.path, filename: filename),
          "docname": prefs.getString('doc_name').toString(),
          "doctype": 'User',
          "attached_to_name": prefs.getString('full_name').toString(),
          "is_private": 0,
          "folder": "Home/Attachments"
        });

        dio.options.headers["Authorization"] =
            prefs.getString('token').toString();
        Response response = await dio.post(
          "${dotenv.env['API_URL']}/api/method/upload_file",
          data: formData,
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          print('File $i uploaded successfully');
          j.add(i);
          print(j);
          print(j.length);
          print(selectedFiles.length);
          if (selectedFiles.length == j.length) {
            selectedFiles.clear();
            Get.snackbar(
              "Success",
            "Great! The file has been uploaded successfully.",
              icon: const Icon(
                PhosphorIcons.check_circle_fill,
                color: Colors.white,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primaryColor,
              borderRadius: 20,
              margin: const EdgeInsets.all(15),
              colorText: Colors.white,
              duration: const Duration(seconds: 4),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            );
            return true;
          }
        } else {
          // Handle error case
          print('Failed to upload file $i');
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }
}
