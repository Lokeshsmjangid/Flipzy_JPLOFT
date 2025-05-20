import 'dart:convert';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/add_seller_repo.dart';
import 'package:flipzy/controllers/businessProfile_controller.dart';
import 'package:flipzy/controllers/edit_business_profile_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';


class EditPersonalInfo extends StatelessWidget {
  String profile;
  String number;
  String email;
  EditPersonalInfo({super.key, this.profile ="", this.number = "", this.email = ""});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditBusinessProfileController>(
        init: EditBusinessProfileController(),
        builder: (cntrl) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: customAppBar(
          backgroundColor: AppColors.bgColor,
          leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
          leadingIcon: IconButton(
              onPressed: (){
                Get.back();},
              icon: Row(
                children: [
                  Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                  addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
                ],
              ).marginOnly(left: 12)),
          centerTitle: true,
          titleTxt: "Edit Personal Info",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: false,
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AppButton(
            onButtonTap: () {
              showLoader(true);
              addSellerApi(
                businessName: AuthData().userModel?.businessName??'',
                storeDescription: AuthData().userModel?.storeDescription??'',
                email: AuthData().userModel?.email??'',
                mobileNumber: '${AuthData().userModel?.mobileNumber??''}',
                accountHolderName: AuthData().userModel?.accountHolderName??'',
                bankName: AuthData().userModel?.bankName??'',
                accountNumber: AuthData().userModel?.accountNumber??'',
                businessCheck: AuthData().userModel?.businessCheck??false,
                rcNumber: AuthData().userModel?.rcNumber??'',
                image: cntrl.selectedFile.isNotEmpty?cntrl.selectedFile[0]:null
              ).then((value) {
                showLoader(false);
                if (value.status == true) {
                  LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                  AuthData().getLoginData();
                  Get.back();
                  Get.back();
                } else if (value.status == false) {
                  showToastError('${value.message}');
                }
              });
            },
            buttonText: 'Save', buttonTxtColor: AppColors.blackColor,).marginSymmetric(horizontal: 4),
        ).marginOnly(bottom: 10),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [

                GestureDetector(
                  onTap: () {
                    cntrl.showCameraGalleryDialog(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if(cntrl.selectedFile.isNotEmpty)
                          ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.file(File(cntrl.selectedFile[0]!.path.toString()),fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.40,)),

                        if(cntrl.selectedFile.isEmpty && AuthData().userModel?.profileImage !='')
                          ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: CachedImageCircle2(isCircular: true,
                                imageUrl: '${AuthData().userModel!.profileImage}',
                                fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.40,)),


                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: SvgPicture.asset(
                              AppAssets.uploadPPImg,

                              fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                            ).marginAll(40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 40),

                Align(
                    alignment: Alignment.centerLeft,
                    child: addText500("Mobile Number", color: AppColors.blackColor)),
                SizedBox(height: 10),

                CustomTextField(
                  controller: cntrl.mobileCtrl,
                    hintText: 'Enter Mobile Number',
                    readOnly: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                      LengthLimitingTextInputFormatter(12),  // Limits input to 15 digits
                    ],
                    validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Mobile number is required.'),
                          MinLengthValidator(8, errorText: 'Mobile number must be at least 8 digits'),
                          MaxLengthValidator(12, errorText: 'Mobile number must not exceed 12 digits')
                    ]),
                    prefixIcon: SvgPicture.asset(AppAssets.textCallIcon)),

                SizedBox(height: 20),

                Align(
                    alignment: Alignment.centerLeft,
                    child: addText500("Email", color: AppColors.blackColor)),
                SizedBox(height: 10),

                CustomTextField(
                    readOnly: true,
                    controller: cntrl.emailCtrl,
                    hintText: 'Enter your email ',
                    validator: MultiValidator([RequiredValidator(errorText: 'Email is required.'),
                      EmailValidator(errorText: 'Please enter valid email.')
                    ]),
                    prefixIcon: SvgPicture.asset(AppAssets.textMailIcon)),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      );
    });
  }
}
