import 'dart:convert';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/delete__account_repo.dart';
import 'package:flipzy/Screens/business_profile/edit_bank_info.dart';
import 'package:flipzy/Screens/business_profile/edit_business_info.dart';
import 'package:flipzy/Screens/business_profile/edit_personal_info.dart';
import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/controllers/businessProfile_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_acount_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessProfileController>(
        init: BusinessProfileController(),
        builder: (cntrl) {
      return Scaffold(
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
          titleTxt: "Business Profile",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
             //ProfilePercent
                Stack(
                  children: [
                    CircularPercentIndicator(
                      radius: 50,
                      lineWidth: 4.0,
                      percent: 0.50,
                      startAngle: 180,
                      fillColor: Colors.transparent,progressColor: AppColors.blackColor,
                      backgroundColor: AppColors.greenColor,

                      center: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          // child: Image.asset(AppAssets.brandImage),
                          child: CachedImageCircle2(
                              isCircular: true,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              imageUrl: '${AuthData().userModel?.profileImage}'),
                          // child: Image.network(
                          //   "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                          //   // width: 50, height: 50,
                          //   fit: BoxFit.contain,
                          // ),
                        ),
                      ),
                      /* linearGradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFFFD854),
                              Color(0xffFF9249),
                              Color(0xffEB4A66),
                              Color(0xffCB39A6)
                            ],
                          ),
                          rotateLinearGradient: true,*/
                    ),

                    Positioned(
                        right: 0,
                        left: 0,
                        bottom: -4,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(0XFFE9F0CA),width: 2),
                                gradient: LinearGradient(
                                  tileMode: TileMode.repeated,
                                  colors: [Color(0xFF91B636), Color(0xffBBD15B), Color(0xff91B636)
                                  ],)
                            ),

                            child: addText700('${AuthData().userModel?.profilePercentage}%',fontSize: 11,fontFamily: 'Poppins'),
                          ),
                        )),
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addText700("${AuthData().userModel?.firstname} ${AuthData().userModel?.lastname}"),
                    SizedBox(width: 10,),
                    SvgPicture.asset(AppAssets.verifiedIc),
                  ],
                ),
                SizedBox(height: 2,),
                addText500("Complete Profile", color: AppColors.blackColor),


                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30) )
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        // height: MediaQuery.of(context).size.height * 0.3,
                        // width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: AppColors.greyColor,),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                addText700("Personal Info", maxLines: 2, color: AppColors.blackColor, fontSize: 15),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(EditPersonalInfo());
                                    },
                                    child: addText700("Edit", maxLines: 2, color: AppColors.blackColor, fontSize: 13))
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.textCallIcon),
                                ),
                                SizedBox(width: 20,),
                                addText500("${AuthData().userModel?.mobileNumber??''}", maxLines: 1, color: AppColors.blackColor, fontSize: 15),
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.mailIC),
                                ),
                                SizedBox(width: 20,),
                                addText500("${AuthData().userModel?.email??''}", maxLines: 1, color: AppColors.blackColor, fontSize: 15),
                              ],
                            ),

                          ],
                        ),
                      ),
          //BusinessInfo
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        // height: MediaQuery.of(context).size.height * 0.3,
                        // width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: AppColors.greyColor,),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                addText700("Business Info", maxLines: 2, color: AppColors.blackColor, fontSize: 15),
                                GestureDetector(
                                    onTap: () {
                                      print("object");
                                      Get.to(EditBusinessInfo());
                                    },
                                    child: addText700("Edit", maxLines: 2, color: AppColors.blackColor, fontSize: 13))
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.storeIc),
                                ),
                                SizedBox(width: 20,),
                                addText500("${AuthData().userModel?.businessName??''}", maxLines: 1, color: AppColors.blackColor, fontSize: 15),
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.storeIc),
                                ),
                                SizedBox(width: 20,),
                                Expanded(child: addText500("${AuthData().userModel?.storeDescription??''}", maxLines: 2, color: AppColors.blackColor, fontSize: 15)),
                              ],
                            ),

                          ],
                        ),
                      ),

           //BankInfo
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        // height: MediaQuery.of(context).size.height * 0.3,
                        // width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: AppColors.greyColor,),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                addText700("Bank Info", maxLines: 2, color: AppColors.blackColor, fontSize: 15),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(EditBankInfo());
                                    },
                                    child: addText700("Edit", maxLines: 2, color: AppColors.blackColor, fontSize: 13))
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.personIC),
                                ),
                                SizedBox(width: 20,),
                                addText500("${AuthData().userModel?.accountHolderName??''}", maxLines: 1, color: AppColors.blackColor, fontSize: 15),
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.bankBuildingIC),
                                ),
                                SizedBox(width: 20,),
                                Expanded(child: addText500("${AuthData().userModel?.bankName??''}", maxLines: 2, color: AppColors.blackColor, fontSize: 15)),
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.bankBuildingIC),
                                ),
                                SizedBox(width: 20,),
                                Expanded(child: addText500("${AuthData().userModel?.accountNumber??''}", maxLines: 2, color: AppColors.blackColor, fontSize: 15)),
                              ],
                            ),

                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration : BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: SvgPicture.asset(AppAssets.bankBuildingIC),
                                ),
                                SizedBox(width: 20),
                                Expanded(child: addText500("${AuthData().userModel?.ifsc??''}", maxLines: 2, color: AppColors.blackColor, fontSize: 15)),
                              ],
                            )]))])),
                GestureDetector(
                    onTap: () {
                      // DeleteAccountDialog
                      DeleteAccountDialog.show(context,onTap1: () {
                        Get.back();
                        showLoader(true);
                        deleteAccountApi(userType: 'Seller').then((value){
                          showLoader(false);
                          if(value.status==true);
                          showToast('Delete seller profile successfully');
                          LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                          AuthData().getLoginData();
                          Get.to(CustomBottomNav());
                        });
                      }, onTap2: ()=> Get.back());
                    },
                    child: addText500("Delete Account", color: AppColors.redColor)),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      );
    });
  }
}
