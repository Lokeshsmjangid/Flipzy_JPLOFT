import 'package:flipzy/controllers/forgot_password_email_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'forgot_password_otp_screen.dart';
import 'setup_profile_sreen.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addHeight(50),
              Row(
                children: [
                  backButton(onTap: () {
                    Get.back();
                  }),
                  addText700('Verify Email Address', fontFamily: 'Manrope',
                      fontSize: 22),
                ],
              ),
              SizedBox(height: 10,),
              addText500(
                  'Enter your email address below, and we’ll send you a verification link. Simply click on the link in your email to complete the verification process.',
                  fontSize: 13,
                  fontFamily: 'Manrope',
                  color: AppColors.blackColor),
              addHeight(40),

              addText500('Email', fontSize: 14, color: AppColors.blackColor),
              addHeight(6),
              CustomTextField(
                  // controller: logic.emailController,
                  hintText: 'Enter your email ',
                  validator: MultiValidator([RequiredValidator(errorText: 'Email is required.'),
                    EmailValidator(errorText: 'Please enter valid email.')
                  ]),
                  prefixIcon: SvgPicture.asset(AppAssets.mailIC)),
              addHeight(16),

              addHeight(20),
              AppButton(buttonText: 'Send Link', buttonTxtColor: AppColors.blackColor , onButtonTap: () {
                // if(formKey.currentState?.validate()?? false){
                //
                // }
                Get.to(SetupProfileScreen());
              },),
            ],
          ),
        ),
      ).marginSymmetric(horizontal: 16),
    );
  }
}
