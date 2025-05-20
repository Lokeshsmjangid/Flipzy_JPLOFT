import 'package:flipzy/Api/repos/fgPass_send_otp_repo.dart';
import 'package:flipzy/Api/repos/verift_fgPass_otp_repo.dart';
import 'package:flipzy/controllers/forgot_password_otp_controller.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';

import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<ForgotPasswordOtpController>(builder: (logic) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addHeight(50),
                Row(
                  children: [
                    backButton(onTap: () {
                      Get.back();
                    }),
                    addText700('Forgot Your Password?', fontFamily: 'Manrope',
                        fontSize: 22),
                  ],
                ),
                addHeight(10),
                addText400(
                    'We\'ve sent a 4 digit OTP to your email ${logic.email} below to verify your account.',
                    fontSize: 13,
                    fontFamily: 'Manrope',
                    color: AppColors.blackColor),

                addHeight(40),

                addText500('OTP', fontSize: 14, color: AppColors.blackColor),
                addHeight(6),

                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: logic.pinController,
                      animationType: AnimationType.none, // No animation for simplicity
                      autoDismissKeyboard: true,
                      autoFocus: true,
                      showCursor: logic.hasError?true:false,
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

                      // Display a dash (-) when the field is empty
                      // showEmptyFieldIndicator: true,
                      // emptyFieldIndicator: Text(
                      //   '-',
                      //   style: TextStyle(
                      //     fontSize: 24,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // Text style for entered digits
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      // Space between fields
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      animationDuration: const Duration(milliseconds: 300),
                      cursorColor: Color(0XFF989898),
                      cursorHeight: 2,
                      cursorWidth: 12,
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
                        if(value.length<4)
                        setState(() {
                          logic.hasError = true;
                        });
                      },
                      beforeTextPaste: (text) {
                        return true; // Allow pasting text
                      },
                    ),
                  ),
                ),


                addHeight(36),
                AppButton(
                  buttonText: 'Reset Password',
                  buttonColor: logic.pinController.text.length<4?AppColors.greyColor:AppColors.primaryColor,
                  buttonTxtColor: AppColors.blackColor, onButtonTap: () {
                  if(logic.pinController.text.length<4){
                    setState(() {
                      logic.hasError = true;
                    });

                  } else{
                    showLoader(true);
                    verifyFgPassOTPApi(
                        email: logic.email,
                        otp: logic.pinController.text).then((value){
                      showLoader(false);
                      if(value.status==true){
                        Get.toNamed(AppRoutes.setNewPasswordScreen,
                            arguments: {'email':logic.email});

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
                   Obx(() =>  logic.timerVal.value>0?addText500(
                       '00:${logic.timerVal.value}s',
                       fontSize: 14,
                       fontFamily: 'Manrope',
                       color: AppColors.blackColor):SizedBox.shrink(),)
                  ],
                ),

                addHeight(10),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      if(logic.timerVal.value<1){
                        showLoader(true);
                        fgPassSendOTPApi(email: logic.email).then((value){
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
                        color: AppColors.blackColor,decoration: TextDecoration.underline,height: 0),
                  ),
                ),


              ],
            ),
          ),
        );
      }).marginSymmetric(horizontal: 16),
    );
  }
}
