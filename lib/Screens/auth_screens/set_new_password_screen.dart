import 'dart:ui';

import 'package:flipzy/Api/repos/reset_pass_repo.dart';
import 'package:flipzy/Screens/auth_screens/signup_screen.dart';
import 'package:flipzy/controllers/forgot_password_email_controller.dart';
import 'package:flipzy/controllers/set_new_password_controller.dart';
import 'package:flipzy/dialogues/password_update_dialogue.dart';
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
import 'forgot_password_otp_screen.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<SetNewPasswordController>(builder: (logic) {
        return Form(
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
                      addText700('Set a New Password', fontFamily: 'Manrope',
                          fontSize: 22),
                    ],
                  ),
                  addText500('Create a strong password to keep your account secure.',
                      fontSize: 13, fontFamily: 'Manrope', color: AppColors.blackColor),
                  addHeight(40),

                  addText500('New Password', fontSize: 14, color: AppColors.blackColor),
                  addHeight(6),
                  CustomTextField(hintText: 'Enter New Password',
                    controller: logic.passController,
                    prefixIcon: SvgPicture.asset(AppAssets.textPasswordIcon),
                    obscureText: logic.obsurePass,
                    suffixIcon: GestureDetector(
                        onTap: logic.ontapPassSuffix,
                        child: SvgPicture.asset(logic.obsurePass?AppAssets.eyeOnIcon:AppAssets.eyeOffIcon,height: 16,width: 20,)),
                    validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Password is required.'),
                          MinLengthValidator(6, errorText: 'Password must be at least 6 char/digits long'),
                          PatternValidator(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                              errorText: 'Use uppercase, number & symbol.'),

                        ]),
                  ),
                  addHeight(16),

                  addText500('Re-New Password', fontSize: 14, color: AppColors.blackColor),
                  addHeight(6),
                  CustomTextField(hintText: 'Re-Enter New Password',
                    controller: logic.confPassController,
                    prefixIcon: SvgPicture.asset(AppAssets.textPasswordIcon),
                    obscureText: logic.obsureRePass,
                    suffixIcon: GestureDetector(
                        onTap: logic.ontapRePassSuffix,
                        child: SvgPicture.asset(logic.obsureRePass?AppAssets.eyeOnIcon:AppAssets.eyeOffIcon,height: 16,width: 20,)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Re-Enter new password field is required.'.tr;
                      }
                      else if (logic.confPassController.text.length<6) {
                        return 'Re-Enter new password must be at least 6 char/digits long'.tr;
                      }
                      else if (logic.passController.text !=logic.confPassController.text ){
                        return 'Both Passwords Must Match';
                      }
                      return null; // Return null to indicate validation success
                    },
                  ),
                  addHeight(16),

                  addHeight(20),
                  AppButton(
                    buttonText: 'Change Password', buttonTxtColor: AppColors.blackColor, onButtonTap: () {
                    if(formKey.currentState?.validate()??false){

                     showLoader(true);
                     resetPasswordApi(email: logic.email,newPassword: logic.confPassController.text).then((value){
                       showLoader(false);
                       if(value.status==true){
                         logic.passController.clear();
                         logic.confPassController.clear();
                         PasswordUpdateDialog.show(context, onTap: () => Get.offAllNamed(AppRoutes.loginScreen));
                       } else if(value.status==false){
                         showToastError('${value.message}');
                       }
                     });
                    };
                  },),
                ],
              ),
            ),
          ),
        );
      }).marginSymmetric(horizontal: 16),
    );
  }
}