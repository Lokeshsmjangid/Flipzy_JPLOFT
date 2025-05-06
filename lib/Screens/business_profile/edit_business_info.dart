import 'dart:convert';

import 'package:flipzy/Api/repos/add_seller_repo.dart';
import 'package:flipzy/controllers/businessProfile_controller.dart';
import 'package:flipzy/controllers/edit_business_profile_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../custom_widgets/CustomTextField.dart';
import '../../custom_widgets/appButton.dart';

class EditBusinessInfo extends StatelessWidget {
   EditBusinessInfo({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditBusinessProfileController>(
        init: EditBusinessProfileController(),
        builder: (cntrl) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: customAppBar(
              backgroundColor: AppColors.whiteColor,
              leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
              leadingIcon: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 16,),
                    addText400("Back", color: AppColors.blackColor),
                  ],
                ).marginOnly(left: 12),
              ),
              centerTitle: true,
              titleTxt: "Edit Personal Info",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              actionItems: [
              ],
              bottomLine: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 40,),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500("Store/Business Name", color: AppColors.blackColor)),
                    SizedBox(height: 10,),

                    CustomTextField(
                      controller: cntrl.storeName,
                        hintText: 'Enter your store or business name',
                        validator: MultiValidator([RequiredValidator(errorText: 'Business name is required.'),
                        ]),
                        prefixIcon: SvgPicture.asset(AppAssets.storeIc)),

                    SizedBox(height: 20,),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500("Store Description", color: AppColors.blackColor)),
                    SizedBox(height: 10,),

                    CustomTextField(
                        controller: cntrl.storeDesc,
                        hintText: 'Describe your store in a few words...',
                        validator: MultiValidator([RequiredValidator(errorText: 'Store desc is required.'),
                        ]),
                        prefixIcon: SvgPicture.asset(AppAssets.storeIc)),

                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AppButton(
                        onButtonTap: () {
                          if(formKey.currentState?.validate()??false){
                            showLoader(true);
                            addSellerApi(
                                businessName: cntrl.storeName.text,
                                storeDescription: cntrl.storeDesc.text,
                                email: AuthData().userModel?.email??'',
                                mobileNumber: '${AuthData().userModel?.mobileNumber??''}',
                                accountHolderName: AuthData().userModel?.accountHolderName??'',
                                bankName: AuthData().userModel?.bankName??'',
                                accountNumber: AuthData().userModel?.accountNumber??'',
                                businessCheck: AuthData().userModel?.businessCheck??false,
                                rcNumber: AuthData().userModel?.rcNumber??'',
                                image: null
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
                          }
                        },
                        buttonText: 'Save', buttonTxtColor: AppColors.blackColor,).marginSymmetric(horizontal: 4),
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
