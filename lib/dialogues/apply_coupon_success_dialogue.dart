import 'dart:developer';
import 'dart:ui';

import 'package:flipzy/Api/api_models/coupon_model.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ApplyCouponSuccessDialog {
  static void show(BuildContext context,Coupon? coupon) {
    showDialog(
      context: context,
      barrierColor: AppColors.blueColor.withOpacity(0.5),
      barrierDismissible: false,
      builder: (_) => ApplyCouponSuccessDialogWidget(coupon: coupon,),
    );
  }
}

class ApplyCouponSuccessDialogWidget extends StatelessWidget {
  Coupon? coupon;

  ApplyCouponSuccessDialogWidget({this.coupon});


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
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric( horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.containerBorderColor),
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20), // Set the border radius
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addHeight(40),
                    addText700("'${coupon?.promoCode?.toUpperCase()??''}' applied",textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor).marginSymmetric(horizontal: 20),
                    addText400('${coupon?.shortDescription??''}',textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 16,color: AppColors.blackColor).marginSymmetric(horizontal: 20),
                    // addText500('"We appreciate you taking the time to share your experience. Your feedback helps us improve and serve you better. If you need any further assistance, feel free to reach out to our support team."',
                    //     fontFamily: 'Manrope',fontSize: 13,textAlign: TextAlign.center,color: AppColors.textColor1).marginSymmetric(horizontal: 10),


                    addHeight(20),
                    addText700('YAY!',
                        textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 16,color: Colors.deepOrange).marginSymmetric(horizontal: 20),

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
                      child: SvgPicture.asset(AppAssets.cancelIcon))),
              Positioned(
                  right: 0,
                  left: 0,
                  top: -20,
                  child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.deepOrange),
                          child: Image.asset(AppAssets.couponAppliedLogo,color: Colors.white,height: 40,width: 40,))))
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
