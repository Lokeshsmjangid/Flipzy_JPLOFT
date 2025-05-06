import 'package:flipzy/Api/repos/fgPass_send_otp_repo.dart';
import 'package:flipzy/controllers/forgot_password_email_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  ForgotPasswordEmailScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<ForgotPasswordEmailController>(builder: (logic) {
        return Form(
          key: formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addHeight(52),
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
                addText500(
                    'Enter your registered email id below, and we’ll send you an OTP to reset your password.',
                    fontSize: 13,
                    fontFamily: 'Manrope',
                    color: AppColors.blackColor),
                addHeight(40),

                addText500('Email', fontSize: 14, color: AppColors.blackColor),
                addHeight(6),
                CustomTextField(
                    controller: logic.emailController,
                    hintText: 'Enter your email ',
                    validator: MultiValidator([RequiredValidator(errorText: 'Email is required.'),
                    EmailValidator(errorText: 'Please enter valid email.')
                    ]),
                    prefixIcon: SvgPicture.asset(AppAssets.textMailIcon)),
                addHeight(16),

                addHeight(20),
                AppButton(buttonText: 'Request OTP', buttonTxtColor: AppColors.blackColor, onButtonTap: () {
                  if(formKey.currentState?.validate()?? false){
                    showLoader(true);
                    fgPassSendOTPApi(email: logic.emailController.text).then((value){
                      showLoader(false);
                      if(value.status==true){
                        Get.toNamed(AppRoutes.forgotPasswordOtpScreen,arguments: {
                          'email':logic.emailController.text,'otp':value.otp});
                      } else if(value.status==false){
                        showToastError('${value.message}');
                      }
                    });
                  }

                },),
              ],
            ),
          ),
        );
      }).marginSymmetric(horizontal: 16),
    );
  }
}
