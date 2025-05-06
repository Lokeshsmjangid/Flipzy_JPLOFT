import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteSellerController extends GetxController {
  bool isBusiness = false;
  TextEditingController businessName = TextEditingController();
  TextEditingController businessDesc = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessPhone = TextEditingController();
  TextEditingController businessAH = TextEditingController();
  TextEditingController businessBN = TextEditingController();
  TextEditingController businessAN = TextEditingController();
  TextEditingController businessIFSC = TextEditingController();
  TextEditingController businessRC = TextEditingController();


  List<File?> selectedFile = [];
  void showCameraGalleryDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  pickImage(ImageSource.camera); // Open the camera
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Open Gallery'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  pickImage(ImageSource.gallery); // Open the gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedFile.clear();
      // Handle the selected image
      print('Image selected: ${image.path}');
      selectedFile.add(File(image.path)) ;
      update();
    } else {
      print('No image selected.');
    }
  }

}