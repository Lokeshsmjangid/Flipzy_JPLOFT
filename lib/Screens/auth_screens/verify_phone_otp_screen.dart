import 'dart:convert';

import 'package:flipzy/Api/repos/resend_mobile_otp_repo.dart';
import 'package:flipzy/Api/repos/verift_mobile_otp_repo.dart';
import 'package:flipzy/controllers/forgot_password_otp_controller.dart';
import 'package:flipzy/controllers/verify_phone_otp_controller.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';

import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'setup_profile_sreen.dart';
import 'verify_email_screen.dart';

class VerifyPhoneOtpScreen extends StatefulWidget {
  VerifyPhoneOtpScreen({super.key});

  @override
  State<VerifyPhoneOtpScreen> createState() => _VerifyPhoneOtpScreenState();
}

class _VerifyPhoneOtpScreenState extends State<VerifyPhoneOtpScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<VerifyPhoneOtpController>(builder: (logic) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addHeight(50),
              Row(
                children: [
                  backButton(onTap: () {
                    Get.back();
                  }),
                  addText700('Verify Your Phone Number', fontFamily: 'Manrope',
                      fontSize: 22),
                ],
              ),
              addText500(
                  'We\'ve sent a 4 digit OTP to your mobile number ${logic.country_code} ${logic.phone_number} below to verify your account.',
                  fontSize: 13,
                  fontFamily: 'Manrope',
                  color: AppColors.blackColor),

              addHeight(40),

              addText500('Mobile Number(${logic.otp})', fontSize: 14, color: AppColors.blackColor),
              addHeight(6),

              Center(
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: logic.pinController,
                  animationType: AnimationType.none, // No animation for simplicity
                  autoDismissKeyboard: true,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box, // Square shape
                    borderRadius: BorderRadius.circular(10), // Slightly rounded corners
                    borderWidth: 1.0,
                    inactiveBorderWidth: 1.0,
                    activeBorderWidth: 1.0,
                    selectedBorderWidth: 1.0,
                    errorBorderWidth: 1.0,
                    disabledBorderWidth: 1.0,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    // Border colors
                    inactiveColor: AppColors.greyColor, // Border color for empty fields
                    activeColor: AppColors.greyColor, // Border color for focused field
                    selectedColor: AppColors.greyColor, // Border color for selected field
                    // errorColor: Colors.red,
                    disabledColor: AppColors.greyColor,
                    // Fill colors
                    inactiveFillColor: Colors.white, // Background for empty fields
                    activeFillColor: AppColors.primaryColor, // Background for filled fields
                    selectedFillColor: Colors.transparent, // Background for selected field
                  ),

                  textStyle: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Manrope'
                  ),
                  // Space between fields
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  animationDuration: const Duration(milliseconds: 300),
                  cursorColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true, // Enable fill colors
                  onCompleted: (v) {
                    print("Completed OTP entry: $v");
                    setState(() {
                      logic.hasError = false;
                    });
                  },
                  onChanged: (value) {
                    print("OTP changed: $value");
                  },
                  beforeTextPaste: (text) {
                    return true; // Allow pasting text
                  },
                ),
              ),
              Visibility(
                child: addText500(logic.pinController.text.length<4?
                'Fill all fields':"Wrong PIN!",color: Colors.red,fontFamily: 'Manrope',fontSize: 14,height: 0
                ),
                visible: logic.hasError,
              ).marginSymmetric(horizontal: 14),

              addHeight(30),
              AppButton(buttonText: 'Verify and Continue', buttonTxtColor: AppColors.blackColor, onButtonTap: () {
                if(logic.pinController.text.length<4){
                  setState(() {
                    logic.hasError = true;
                  });

                } else{
                  showLoader(true);
                  verifyMobileOTPApi(
                      mobileNumber: logic.phone_number,
                      otp: logic.pinController.text).then((value){
                    showLoader(false);
                    if(value.status==true){
                      LocalStorage().setValue(LocalStorage.USER_ACCESS_TOKEN, value.token.toString());
                      LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                      AuthData().getLoginData();
                      Get.toNamed(AppRoutes.setupProfileScreen);
                    } else if(value.status==false){
                      showToastError('${value.message}');
                    };
                  });

                }

              },),


              addHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addText500(
                      'Didn’t receive the OTP? ',
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      color: AppColors.blackColor),

                  Obx(() => logic.timerVal.value>0
                      ? addText500(
                      '00:${logic.timerVal.value}s',
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      color: AppColors.blackColor)
                      : SizedBox.shrink()),
                ],
              ),

              addHeight(10),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    if(logic.timerVal.value<1){
                      showLoader(true);
                      resendPhoneOTPApi(mobileNumber: logic.phone_number).then((value){
                        showLoader(false);
                        if(value.status==true){
                          logic.pinController.clear();
                          logic.startATimerFunc();
                          showToast('${value.message}');
                          logic.otp = value.otp.toString();
                          logic.update();
                        } else if(value.status==false){
                          showToastError('${value.message}');
                        }

                      });
                    }

                  },
                  child: addText600(
                      'Resend OTP',
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      color: AppColors.blackColor,
                      decoration: TextDecoration.underline,height: 0),
                ),
              ),


            ],
          ),
        );
      }).marginSymmetric(horizontal: 16),
    );
  }
}
