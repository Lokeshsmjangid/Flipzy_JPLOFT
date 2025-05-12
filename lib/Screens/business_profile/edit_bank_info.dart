import 'dart:convert';

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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class EditBankInfo extends StatelessWidget {
  EditBankInfo({super.key});
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
              titleTxt: "Edit Bank Info",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: true,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AppButton(
                onButtonTap: () {
                  if(formKey.currentState?.validate()??false){
                    showLoader(true);
                    addSellerApi(
                        businessName: AuthData().userModel?.businessName??'',
                        storeDescription: AuthData().userModel?.storeDescription??'',
                        email: AuthData().userModel?.email??'',
                        mobileNumber: '${AuthData().userModel?.mobileNumber??''}',
                        accountHolderName: cntrl.ahNameCtrl.text??'',
                        bankName: cntrl.bankNameCtrl.text??'',
                        accountNumber: cntrl.bankNumberCtrl.text??'',
                        ifsc: cntrl.ifscCtrl.text,
                        businessCheck: AuthData().userModel?.businessCheck??false,
                        rcNumber: AuthData().userModel?.rcNumber??'',
                        image: cntrl.selectedFile.isNotEmpty?cntrl.selectedFile[0]:null,
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
            ).marginOnly(bottom: 10),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                                //ACC_HOLDER
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Account Holder Name", color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: cntrl.ahNameCtrl,
                          hintText: 'Account Holder Name',
                          textCapitalization: TextCapitalization.words,
                          validator: MultiValidator([RequiredValidator(errorText: 'Account Holder Name is required.'),
                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.personIC)),

                      SizedBox(height: 20,),
                                //BANK_NAME
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Bank Name", color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: cntrl.bankNameCtrl,
                          hintText: 'Enter bank name',
                          textCapitalization: TextCapitalization.characters,
                          validator: MultiValidator([RequiredValidator(errorText: 'Bank Name is required.'),
                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.bankBuildingIC)),

                      SizedBox(height: 20,),
                                //Acc_Numb
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Account Number", color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: cntrl.bankNumberCtrl,
                          hintText: 'Enter your bank account number',
                          keyboardType: TextInputType.number,



                          validator: MultiValidator([RequiredValidator(errorText: 'Account Number is required.'),]),
                          prefixIcon: SvgPicture.asset(AppAssets.bankBuildingIC)),

                      SizedBox(height: 20,),
                                //IFSC_CODE
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("IFSC Code", color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: cntrl.ifscCtrl,
                          hintText: 'IFSC Code',
                          textCapitalization: TextCapitalization.characters,
                          validator: MultiValidator([RequiredValidator(errorText: 'Ifsc code is required.')]),
                          prefixIcon: SvgPicture.asset(AppAssets.bankBuildingIC)),

                      // Spacer(),
                      //
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 5),
                      //   child: AppButton(
                      //     onButtonTap: () {
                      //       // Get.to(BusinessProfile());
                      //       Get.back();
                      //       Get.back();
                      //     },
                      //     buttonText: 'Save', buttonTxtColor: AppColors.blackColor,).marginSymmetric(horizontal: 4),
                      // ),

                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
