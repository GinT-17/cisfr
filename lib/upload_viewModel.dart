import 'dart:convert';
import 'dart:io';
import 'package:cisfr/viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadViewModel extends Viewmodel {
  File? cameraImage;
  File? storageImage;

  Future<File?> selectImageStorage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final temp = File(image.path);
      this.storageImage = temp;
      return storageImage;
    } on PlatformException {}
    return null;
  }

  Future<String> getImageLocation() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return '';
      final temp = File(image.path);
      this.storageImage = temp;
      return image.path;
    } on PlatformException {}
    return '';
  }

  Future selectImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final temp = File(image.path);
      this.cameraImage = temp;
      return cameraImage;
    } on PlatformException {}
  }

  Future<void> checkWanted(String path) async {
    var jsonResponse;
    var response =
        http.MultipartRequest('POST', Uri.parse("http://myApiTestBooking"));

    response.files.add(new http.MultipartFile.fromBytes(
      "file",
      File(path)
          .readAsBytesSync(), //UserFile is my JSON key,use your own and "image" is the pic im getting from my gallary
      filename: "Image.jpg",
      // contentType: MediaType('image', 'jpg')
    ));

    response.send().then((response) async {
      if (response.statusCode == 200) {
        // isApiCallProcess = false;
        final respBody = await response.stream
            .bytesToString(); // this is how we print body for Multipart request
        jsonResponse = json.decode(respBody.toString());
        print(respBody);
        print("Uploaded!");

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Booked"),
        //   backgroundColor: Color(0xFF00b3a4),
        // ));

        //  Navigator.push(context,new MaterialPageRoute( builder: (context) =>new MyTestReqDetailsPage(),));
        // Navigator.push(
        //     context,
        //     new MaterialPageRoute(
        //       builder: (context) => new Home2(),
        //     ));
      }
    });
  }
}
