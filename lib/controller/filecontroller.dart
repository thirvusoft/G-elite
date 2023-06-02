import "dart:io";
import "package:dio/dio.dart";
import "package:file_picker/file_picker.dart";
import "package:get/state_manager.dart";

class FilePickerController extends GetxController {
  List selectedFiles = [].obs;

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
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
    print(selectedFiles.runtimeType);
    Dio dio = Dio();
    List<int> j = [];

    try {
      for (int i = 0; i < selectedFiles.length; i++) {
        String filePath = selectedFiles[i] as String;

        File file = File(filePath);
        String filename = file.path.split("/").last;

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(file.path, filename: filename),
          "docname": "basheerahamed@oxo.in",
          "doctype": 'User',
          "attached_to_name": "basheerahamed",
          "is_private": 0,
          "folder": "Home/Attachments"
        });

        dio.options.headers["Authorization"] =
            "token d196e7d2efb5415:fb698c25127eb6a";
        Response response = await dio.post(
          "https://oxo.thirvusoft.co.in/api/method/upload_file",
          data: formData,
        );

        if (response.statusCode == 200) {
          print('File $i uploaded successfully');
          j.add(i);
          print(j);
          print(j.length);
          print(selectedFiles.length);
          if (selectedFiles.length == j.length) {
            return true; // All files uploaded successfully
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
