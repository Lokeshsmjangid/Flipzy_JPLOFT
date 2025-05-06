import 'dart:developer';
import 'dart:ui';

import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RefundOrderConfirmationDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.blueColor.withOpacity(0.5),
      barrierDismissible: false,
      builder: (_) => RefundOrderConfirmationDialogWidget(),
    );
  }
}

class RefundOrderConfirmationDialogWidget extends StatelessWidget {

  RefundOrderConfirmationDialogWidget();


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

                    addText700('Thanks for the confirmation',textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor).marginSymmetric(horizontal: 20),
                    // addText500('"We appreciate you taking the time to share your experience. Your feedback helps us improve and serve you better. If you need any further assistance, feel free to reach out to our support team."',
                    //     fontFamily: 'Manrope',fontSize: 13,textAlign: TextAlign.center,color: AppColors.textColor1).marginSymmetric(horizontal: 10),



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
        child: Center(child: addText700('Go to Dashboard',fontFamily: 'Manrope',fontSize: 20,color: AppColors.whiteColor)),
      ).marginSymmetric(horizontal: 10),
    );
  }
}
