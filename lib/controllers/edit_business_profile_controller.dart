import 'dart:io';

import 'package:flipzy/resources/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditBusinessProfileController extends GetxController{
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController storeName = TextEditingController();
  TextEditingController storeDesc = TextEditingController();
  TextEditingController ahNameCtrl = TextEditingController();
  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController bankNumberCtrl = TextEditingController();
  TextEditingController ifscCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    AuthData().getLoginData();
    super.onInit();
    if(AuthData().userModel!=null){
      mobileCtrl.text = '${AuthData().userModel?.mobileNumber??''}';
      emailCtrl.text = '${AuthData().userModel?.email??''}';
      storeName.text = '${AuthData().userModel?.businessName??''}';
      storeDesc.text = '${AuthData().userModel?.storeDescription??''}';
      ahNameCtrl.text = '${AuthData().userModel?.accountHolderName??''}';
      bankNameCtrl.text = '${AuthData().userModel?.bankName??''}';
      bankNumberCtrl.text = '${AuthData().userModel?.accountNumber??''}';
      ifscCtrl.text = '${AuthData().userModel?.ifsc??''}';

    }

  }



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