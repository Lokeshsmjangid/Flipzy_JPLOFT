import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/profile_setup_repo.dart';
import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/Screens/home_screen.dart';
import 'package:flipzy/controllers/setup_profile_ctrl.dart';
import 'package:flipzy/dialogues/boost_product_dialogue.dart';
import 'package:flipzy/dialogues/decline_order_dialogue.dart';
import 'package:flipzy/dialogues/decline_order_success_dialogue.dart';
import 'package:flipzy/dialogues/delete_acount_dialogue.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/dialogues/dont_agree_dialogue.dart';
import 'package:flipzy/dialogues/feedback_thanks_dialogue.dart';
import 'package:flipzy/dialogues/get_ready_dialog.dart';
import 'package:flipzy/dialogues/profile_ready_dialogue.dart';
import 'package:flipzy/dialogues/purchase_thanks_dialogue.dart';
import 'package:flipzy/dialogues/review_dialogue.dart';
import 'package:flipzy/dialogues/seller_product_ready_dialogue.dart';
import 'package:flipzy/dialogues/setisfied_product_dialogue.dart';
import 'package:flipzy/dialogues/upload_product_sucess_dialogue.dart';
import 'package:flipzy/dialogues/who_are_you_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';

class SetupProfileScreen extends StatelessWidget {
  SetupProfileScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<SetUpProfileCtrl>(builder: (logic) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  addHeight(50),
                  Row(
                    children: [
                      backButton(onTap: () {
                        Get.back();
                      }),
                      addText700('Let\'s Set Up Your Profile', fontFamily: 'Manrope', fontSize: 22),
                    ],
                  ),

                  addHeight(40),
                  //UploadImage
                  GestureDetector(
                    onTap: () {
                      logic.showCameraGalleryDialog(context);
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
                          if(logic.selectedFile.isNotEmpty)
                            ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.file(File(logic.selectedFile[0]!.path.toString()),fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 0.18,
                                  width: MediaQuery.of(context).size.width * 0.40,)),

                          if(logic.selectedFile.isEmpty && AuthData().userModel?.profileImage !='')
                            ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: CachedImageCircle2(isCircular: true,
                                  imageUrl: '${AuthData().userModel?.profileImage}',
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

                  addHeight(30),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500('First Name', fontSize: 14,
                          color: AppColors.blackColor)),
                  addHeight(6),
                  CustomTextField(
                      hintText: 'Enter First Name',
                      controller: logic.fNameCtrl,
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'First Name is required.'),
                      ]),
                      prefixIcon: SvgPicture.asset(AppAssets.textUserIcon)),
                  addHeight(16),


                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500('Last Name', fontSize: 14,
                          color: AppColors.blackColor)),
                  addHeight(6),
                  CustomTextField(

                      hintText: 'Enter Last Name',
                      controller: logic.lNameCtrl,
                      keyboardType: TextInputType.text,
                      validator: MultiValidator(
                          [RequiredValidator(errorText: 'Last Name is required.'),
                          ]),
                      prefixIcon: SvgPicture.asset(AppAssets.textUserIcon)),
                  addHeight(16),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500(
                          'Email', fontSize: 14, color: AppColors.blackColor)),
                  addHeight(6),
                  CustomTextField(
                      hintText: 'Enter Your Email',
                      controller: logic.emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Email is required.'),
                            EmailValidator(errorText: 'Please enter valid email')
                          ]),
                      prefixIcon: SvgPicture.asset(AppAssets.textMailIcon)),
                  addHeight(16),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500(
                          'Mobile', fontSize: 14, color: AppColors.blackColor)),
                  addHeight(6),
                  CustomTextField(
                      hintText: 'Enter Your Mobile',
                      controller: logic.mobileCtrl,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                        LengthLimitingTextInputFormatter(15),  // Limits input to 15 digits
                      ],
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Mobile is required.'),
                            MinLengthValidator(6, errorText: 'Mobile number must be at least 6 digits'),
                            MaxLengthValidator(15, errorText: 'Mobile number must not exceed 15 digits')
                          ]),
                      prefixIcon: SvgPicture.asset(AppAssets.textCallIcon)),
                  addHeight(16),


                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500(
                          'Location', fontSize: 14, color: AppColors.blackColor)),
                  addHeight(6),
                  // CustomTextField(
                  //
                  //     hintText: 'Enter Your Location',
                  //     controller: logic.locationCtrl,
                  //     keyboardType: TextInputType.text,
                  //     validator: MultiValidator(
                  //         [RequiredValidator(errorText: 'Location is required.')]),
                  //     prefixIcon: SvgPicture.asset(AppAssets.textLocationIcon)),
                  GooglePlaceAutoCompleteTextField(
                    focusNode: focusNode,
                    textEditingController: logic.locationCtrl,
                    googleAPIKey: ApiUrls.googleApiKey,
                    textStyle: ManropeTextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.textColor1),
                    inputDecoration: InputDecoration(
                      errorStyle: TextStyle(color: AppColors.redColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabled: true,
                      hintText: 'Enter Your Location',
                      hintStyle: ManropeTextStyle(color: AppColors.textFieldHintColor,fontWeight: FontWeight.w500),
                      // labelText: widget.labelText,
                      // filled: widget.filled,
                      fillColor: AppColors.containerBorderColor.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(1000)),
                      prefixIcon: SvgPicture.asset(AppAssets.textLocationIcon),
                      // suffixIcon: widget.suffixIcon,
                      prefixIconConstraints: const BoxConstraints(maxHeight: 44,minWidth: 44),// use because unbalanced height of text area after adding prefix icon
                      suffixIconConstraints: const BoxConstraints(maxHeight: 44,minWidth: 44),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primaryColor),
                        borderRadius:BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.containerBorderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(
                            color: AppColors.containerBorderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(
                            color: AppColors.containerBorderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),
                    debounceTime: 800, // Delay before fetching results
                    isLatLngRequired: true, // If you need latitude & longitude
                    placeType: PlaceType.establishment,
                    getPlaceDetailWithLatLng: (prediction) {
                      print("Selected Place: ${prediction.description}");
                      print("Latitude: ${prediction.lat}");
                      print("Longitude: ${prediction.lng}");
                    },
                    itemClick: (prediction) {
                      logic.locationCtrl.text = prediction.description!;
                      logic.locationCtrl.selection = TextSelection.fromPosition(TextPosition(offset: logic.locationCtrl.text.length),);
                      focusNode.requestFocus(); // re-focus to prevent jumping
            },

                  ),

                  addHeight(16),


                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500('Password', fontSize: 14, color: AppColors.blackColor)),
                  addHeight(6),
                  CustomTextField(
                      hintText: 'Enter Your Password',
                      controller: logic.passwordCtrl,
                      keyboardType: TextInputType.text,
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Password is required.'),
                            MinLengthValidator(6, errorText: 'Password must be at least 6 char/digits long'),
                            PatternValidator(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                                errorText: 'Password must include an uppercase, number & special character.'),

                          ]),
                      obscureText: logic.obsurePass,
                      suffixIcon: GestureDetector(
                          onTap: logic.ontapPassSuffix,
                          child: SvgPicture.asset(logic.obsurePass?AppAssets.eyeOnIcon:AppAssets.eyeOffIcon,height: 16,width: 20,)),
                      prefixIcon: SvgPicture.asset(AppAssets.textPasswordIcon)),
                  addHeight(40),


                  AppButton(buttonText: 'Submit',
                    buttonTxtColor: AppColors.blackColor,
                    onButtonTap: () {
                      if(formKey.currentState?.validate()??false){
                        if(logic.locationCtrl.text.isNotEmpty){
                          showLoader(true);
                          profileSetupApi(
                              name: logic.fNameCtrl.text,
                              lName: logic.lNameCtrl.text,
                              email: logic.emailCtrl.text,
                              mobileNumber: logic.mobileCtrl.text,
                              location: logic.locationCtrl.text,
                              password: logic.passwordCtrl.text,
                              image: logic.selectedFile.isNotEmpty?
                              logic.selectedFile[0] : null).then((value){showLoader(false);
                                if(value.status==true){
                              LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                              GetReadyDialog.show(context, onTap: () {

                                AuthData().getLoginData();
                                Get.to(CustomBottomNav());
                              });
                            }
                                else if(value.status==false){
                              showToastError('${value.message}');
                            }});
                        }
                        else{ showToastError('Please enter your location'); }
                      }}),
                  addHeight(24)
                ],
              ).marginSymmetric(horizontal: 16),
            ),
          ),
        );
      }),
    );
  }
}
