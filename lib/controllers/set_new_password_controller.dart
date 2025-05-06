import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetNewPasswordController extends GetxController {

  String? email;
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

  bool obsurePass = true;
  bool obsureRePass = true;

  ontapPassSuffix(){
    obsurePass = !obsurePass;
    update();
  }

  ontapRePassSuffix(){
    obsureRePass = !obsureRePass;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      email = Get.arguments['email'];
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

}