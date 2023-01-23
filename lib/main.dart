import 'dart:io';
import 'package:cisfr/upload_viewModel.dart';
import 'package:cisfr/viewmodel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIS-FR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UploadViewModel viewModel = new UploadViewModel();
  @override
  Widget build(BuildContext context) {
    File? image;
    File? storageImage;
    File? cameraImage;
    String imageLocation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CIS-FR'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
              child: image != null
                  ? Image.file(
                      image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/no-photo.png'),
            ),
            ElevatedButton(
                onPressed: () async {
                  String location = await viewModel.getImageLocation();
                  await viewModel.checkWanted(location);
                },
                child: Text('Check')),
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: OutlinedButton.icon(
                      onPressed: () async {
                        storageImage = await viewModel.selectImageStorage();
                        setState(() => image = storageImage);
                      },
                      icon: Icon(Icons.image_rounded),
                      label: Text('Pick Gallery'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        side: BorderSide(width: 3, color: Colors.blue),
                        primary: Color.fromARGB(255, 77, 76, 76),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      )),
                ),
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 11,
                  child: OutlinedButton.icon(
                      onPressed: () async {
                        // cameraImage =
                        //     await viewModel.selectImageCamera();
                        // setState(() => image = cameraImage);
                      },
                      icon: Icon(Icons.camera_alt_rounded),
                      label: Text('Pick Camera'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        side: BorderSide(width: 3, color: Colors.blue),
                        primary: Color.fromARGB(255, 77, 76, 76),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
