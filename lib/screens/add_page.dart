import "dart:io";

import "package:flutter/material.dart";
import 'package:camera/camera.dart';

import "../widgets/scrollable_news_container.dart";
import "../screens/take_pic_page.dart";

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  XFile? image;

  void showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    if (!mounted) return;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    if (result != null) {
      setState(() {
        image = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            image == null 
                ? const Icon(Icons.image) 
                : Image.file(File(image!.path)),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: (){
                  showCamera();
                },
                child: const Text("Take Picture",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
