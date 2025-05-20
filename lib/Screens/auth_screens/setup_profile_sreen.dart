import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flipzy/Api/repos/profile_setup_repo.dart';
import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/controllers/setup_profile_ctrl.dart';
import 'package:flipzy/dialogues/get_ready_dialog.dart';
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

                      addText700('Let\'s Set Up Your Profile', fontFamily: 'Manrope', fontSize: 22),


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
                                color: AppColors.primaryColor,
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
                      readOnly: logic.locationCtrl.text != "null" || logic.mobileCtrl.text.isNotEmpty? true: false, // by default its true
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                        LengthLimitingTextInputFormatter(12),  // Limits input to 15 digits
                      ],
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Mobile is required.'),
                            MinLengthValidator(8, errorText: 'Mobile number must be at least 8 digits'),
                            MaxLengthValidator(12, errorText: 'Mobile number must not exceed 12 digits')
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

                  CustomTextField(
                      controller: logic.locationCtrl,
                      hintText: 'Enter Your Location',
                      onChanged: (val){
                        logic.deBounce.run(() {
                          logic.getSuggestion(val);
                        });
                      },
                      validator: MultiValidator([RequiredValidator(errorText: 'Location is required.'),]),
                      prefixIcon: SvgPicture.asset(AppAssets.textLocationIcon),
                      suffixIcon: logic.locationCtrl.text.isNotEmpty
                          ? IconButton(onPressed: (){
                        logic.locationCtrl.clear();
                        logic.update();
                      }, icon: Icon(Icons.cancel_outlined))
                          : null),
                  if(logic.placePredication.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: ListView.separated(shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: logic.placePredication.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: (){
                                showLoader(true);
                                logic.getAddressFromPlaceId(logic.placePredication[index].placeId.toString()).then((value) {
                                  if(value.responseCode==200){
                                    log('Manual address:${value.address}');
                                    log('Manual description:${logic.placePredication[index].description}');
                                    logic.locationCtrl.text = "${logic.placePredication[index].description}";
                                    logic.placePredication.clear();
                                    logic.update();
                                    log('Manual city:${value.city}');
                                    log('Manual state:${value.state}');
                                    log('Manual country:${value.country}');
                                    log('Manual postalCode:${value.postalCode}');
                                    log('Manual latitude:${value.latitude}');
                                    log('Manual longitude:${value.longitude}');
                                  }
                                });


                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 14),visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.male_rounded,color: AppColors.blackColor),
                                  addWidth(5),
                                  Expanded(child: addText400('${logic.placePredication[index].description}',fontSize: 14)),
                                ],
                              ),
                              // Add more widgets to display additional information as needed
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
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
                                errorText: 'Use uppercase, number & symbol.'),

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
