import 'dart:developer';
import 'dart:ui';

import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileReadyDialog {
  static void show(BuildContext context,{void Function()? onTap}) {
    showDialog(
      context: context,
       barrierColor: Color(0xff56716a).withOpacity(0.75),
      barrierDismissible: false,
      builder: (_) => ProfileReadyDialogWidget(onTap: onTap),
    );
  }
}

class ProfileReadyDialogWidget extends StatelessWidget {
  void Function()? onTap;

  ProfileReadyDialogWidget({this.onTap});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: AppColors.whiteColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric( horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.containerBorderColor),
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20), // Set the border radius
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addHeight(20),
                    SvgPicture.asset(AppAssets.passwordUpdateImage,height: 100,width: 100,).marginAll(15),

                    addText700('You’re Ready to Buy!',fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor).marginSymmetric(horizontal: 20),
                    addText500('"Your profile is all set up! You can now browse listings, save your favorites, and start reaching out to sellers for your desired items."',
                        fontFamily: 'Manrope',fontSize: 13,textAlign: TextAlign.center,color: AppColors.textColor1).marginSymmetric(horizontal: 10),

                    addHeight(16),
                    continueButton(onTap: onTap),


                    addHeight(20),
                  ],
                ),
              ),

              Positioned(
                  right: 14,
                  top: 14,
                  child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: SvgPicture.asset(AppAssets.cancelIcon)))
            ],
          ),
        ),
      ),
    );
  }
  continueButton({void Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 45),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText700('Go to Dashboard',fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor)),
      ).marginSymmetric(horizontal: 10),
    );
  }
}
