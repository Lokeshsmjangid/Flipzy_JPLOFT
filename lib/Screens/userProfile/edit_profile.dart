import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flipzy/Api/repos/profile_setup_repo.dart';
import 'package:flipzy/controllers/edit_profile_controller.dart';
import 'package:flipzy/controllers/user_profile_controller.dart';
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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/get_utils.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
        init: UserProfileController(),
        builder: (cntrl) {
          return Scaffold(
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
            body: GetBuilder<EditProfileController>(
                init: EditProfileController(),
                builder: (logic) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      addHeight(20),
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

                      SizedBox(height: 40,),
                      //Name
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("First Name",
                              color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: logic.firstname,
                          hintText: 'Enter First Name',
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'First Name is required.'),
                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.personIC)),

                      SizedBox(height: 20,),

                      //Name
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Last Name",
                              color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: logic.lastname,
                          hintText: 'Enter Last Name',
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Last Name is required.'),
                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.personIC)),

                      SizedBox(height: 20,),
                      //MobileNum
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Mobile Number",
                              color: AppColors.blackColor)),
                      SizedBox(height: 10,),
                      CustomTextField(
                        controller: logic.mobileNumber,
                          hintText: 'Enter your number ',
                          readOnly: logic.mobileNumber.text.isNotEmpty?true:false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                            LengthLimitingTextInputFormatter(15),  // Limits input to 15 digits
                          ],
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Mobile number is required.'),

                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.textCallIcon)),

                      SizedBox(height: 20,),
                      //Address
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Location",
                              color: AppColors.blackColor)),
                      SizedBox(height: 10,),

                      CustomTextField(
                          controller: logic.address,
                          hintText: 'Enter your location',
                          onChanged: (val){
                            logic.deBounce.run(() {
                              logic.getSuggestion(val);
                            });
                          },
                          suffixIcon: logic.address.text.isNotEmpty?IconButton(onPressed: (){
                            logic.address.clear();
                            logic.update();
                          }, icon: Icon(Icons.cancel_outlined)):null,
                          prefixIcon: SvgPicture.asset(AppAssets.loactionIc,color: AppColors.containerBorderColor1,)),
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
                                      logic.address.text = "${logic.placePredication[index].description}";
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


                                  // Get.find<EditProfileController>().streetCtrl.text = mlCtrl.placePredication[index].structuredFormatting!.mainText.toString();
                                  //
                                  // var length = mlCtrl.placePredication[index].terms!.length;
                                  //
                                  // for(var i =0;i<length;i++){
                                  //
                                  //   Get.find<EditProfileController>().cityCtrl.text = mlCtrl.placePredication[index].terms![length-3].value.toString();
                                  //   Get.find<EditProfileController>().countryCtrl.text = mlCtrl.placePredication[index].terms![length-1].value.toString();
                                  // }

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

                      SizedBox(height: 20,),

                      //Email
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Email",
                              color: AppColors.blackColor)),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: logic.email,
                          readOnly: true,
                          hintText: 'Enter your email ',
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'email is required.'),
                            EmailValidator(errorText: 'Enter valid email')
                          ]),
                          prefixIcon: SvgPicture.asset(AppAssets.mailIC)),

                      // Spacer(),

                      SizedBox(height: 30,),
                      //Save
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AppButton(
                          onButtonTap: () {
                            if(formKey.currentState?.validate()??false){

                              showLoader(true);
                              profileSetupApi(
                                  name: logic.firstname.text,
                                  lName: logic.lastname.text,
                                  email: logic.email.text,
                                  mobileNumber: logic.mobileNumber.text,
                                  location: logic.address.text,
                                  password: '',
                                image: logic.selectedFile.isNotEmpty?logic.selectedFile[0]:null

                              ).then((value){
                                showLoader(false);
                                if(value.status==true){
                                  LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                                    AuthData().getLoginData(); Get.back();

                                } else if(value.status==false){
                                  showToastError('${value.message}');
                                }});


                            }
                          },
                          buttonText: 'Save',
                          buttonTxtColor: AppColors.blackColor,)
                            .marginSymmetric(horizontal: 4),
                      ),

                      SizedBox(height: 20,)
                    ],
                  ).marginSymmetric(horizontal: 12),
                ),
              );
            }),
          );
        });
  }
}
