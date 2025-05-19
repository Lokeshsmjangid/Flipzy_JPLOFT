import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyPhoneOtpController extends GetxController {
  String? email;
  String? country_code;
  String? phone_number;
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
      country_code = Get.arguments['countryCode'];
      phone_number = Get.arguments['mobileNumber'];
      otp = Get.arguments['otp'];
    }
  }



  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
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

  String maskMobileNumber(String number) {
    if (number.length <= 2) return number; // not enough digits to mask
    String lastTwo = number.substring(number.length - 2);
    String masked = '*' * (number.length - 2);
    return '$masked$lastTwo';
  }

}