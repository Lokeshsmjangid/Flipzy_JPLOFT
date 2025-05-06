import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordOtpController extends GetxController {
  String? email;
  String? otp;

  TextEditingController pinController = TextEditingController();
  bool hasError = false;
  String? errorMessage;

  RxInt timerVal = 0.obs ;
  Timer? _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startATimerFunc();
    if(Get.arguments!=null){
      email = Get.arguments['email'];
      otp = Get.arguments['otp'];
      if(otp!=null){
        pinController.text = otp!;
      }
    }
  }

  startATimerFunc() {
    _timer?.cancel(); // Cancel previous timer if running
    timerVal.value = 30; // Reset timer to 30 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerVal.value > 0) {
        timerVal.value--;
        // print("Timer val is :: ${timerVal.value}");
        // update();// Decrease the timer value
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });

  }



  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
    _timer?.cancel();
  }

}