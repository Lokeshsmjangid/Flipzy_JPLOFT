import 'package:flipzy/Api/repos/register_mobile_no_repo.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'forgot_password_otp_screen.dart';
import 'verify_phone_otp_screen.dart';

class RegisterMobileNumberScreen extends StatelessWidget {
  RegisterMobileNumberScreen({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: SafeArea(
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
                    addText700('Register Your Account', fontFamily: 'Manrope',
                        fontSize: 22),
                  ],
                ),
                SizedBox(height: 10,),
                addText500(
                    'Register today to start buying, selling, and flipping items in your local area. It’s free, fast, and simple!',
                    fontSize: 13,
                    fontFamily: 'Manrope',
                    color: AppColors.blackColor),
                addHeight(40),

                addText500('Mobile Number', fontSize: 14, color: AppColors.blackColor),
                addHeight(6),
                CustomTextField(
                    controller: phoneCtrl,
                    hintText: 'Enter Mobile Number',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                      LengthLimitingTextInputFormatter(15),  // Limits input to 15 digits
                    ],
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Mobile number is required.'),
                      MinLengthValidator(6, errorText: 'Mobile number must be at least 6 digits'),
                      MaxLengthValidator(15, errorText: 'Mobile number must not exceed 15 digits')

                    ]),
                    prefixIcon: SvgPicture.asset(AppAssets.textCallIcon)),

                addHeight(36),
                AppButton(buttonText: 'Sign Up', buttonTxtColor: AppColors.blackColor ,onButtonTap: () {
                  if(formKey.currentState?.validate()?? false){

                    showLoader(true);
                    registerPhoneApi(mobileNumber: phoneCtrl.text).then((value){
                      showLoader(false);
                      if(value.status==true){
                        Get.toNamed(AppRoutes.verifyPhoneOtpScreen,arguments: {
                          'countryCode': '+91',
                          'mobileNumber': '${phoneCtrl.text}',
                          'otp': '${value.otp}',
                        });
                      } else if(value.status==false){
                        showToastError('${value.message}');
                      };
                    });


                  }
                },),
              ],
            ),
          ),
        ),
      ).marginSymmetric(horizontal: 16),
    );
  }
}
