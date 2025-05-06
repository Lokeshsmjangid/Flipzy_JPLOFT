
import 'dart:ui';

import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReviewDialog {
  static void show(BuildContext context,{
    void Function()? onTap,  TextEditingController? reviewCtrl, double initialRating=1.0}) {
    showDialog(
      context: context,
      barrierColor: AppColors.blueColor.withOpacity(0.5),
      barrierDismissible: true,
      builder: (_) => ReviewDialogWidget(onTap: onTap,reviewCtrl: reviewCtrl,initialRating: initialRating,),
    );
  }
}

class ReviewDialogWidget extends StatelessWidget {
  void Function()? onTap;
  TextEditingController? reviewCtrl;
  double? initialRating;

  ReviewDialogWidget({this.onTap,this.reviewCtrl,this.initialRating=1.0});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
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
                    SvgPicture.asset(AppAssets.reviewImage,height: 100,width: 100,).marginAll(15),

                    // addText700('Why you want to decline this order? Please Specify.',textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor),
                    // addText500('"Your profile is complete! You can now upload your products, manage inquiries, and start selling to buyers looking for great deals."',
                    //     fontFamily: 'Manrope',fontSize: 13,textAlign: TextAlign.center,color: AppColors.textColor1).marginSymmetric(horizontal: 10),

                    addHeight(20),

                    Center(
                      child: RatingBar(
                        initialRating: initialRating!, // Default rating
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false, // Allows half-star ratings
                        itemCount: 5, // Number of stars
                        itemSize: 20, // Size of stars
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.amber),
                          half: Icon(Icons.star_half, color: Colors.amber),
                          empty: Icon(Icons.star_border, color: Colors.grey),
                        ),
                        onRatingUpdate: (rating) {
                          print("New Rating: $rating");
                          initialRating = rating;
                          Get.find<OrderListController>().initialRating = rating;
                          Get.find<OrderListController>().update();
                        },
                      ),
                    ),
                    addHeight(20),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500('Review',fontSize: 14)).marginSymmetric(horizontal: 10),
                    addHeight(6),

                    CustomTextField(
                      controller: reviewCtrl,
                      hintText: 'Enter Review',maxLines: 3,
                    ).marginSymmetric(horizontal: 10),


                    addHeight(16),
                    continueButton(buttonText: 'Submit',onTap: onTap,color: AppColors.primaryColor, buttonTextColor: AppColors.blackColor),

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
  continueButton({void Function()? onTap,String? buttonText,Color? color,Color? buttonTextColor}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 46),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText700('$buttonText',fontFamily: 'Manrope',fontSize: 20,color: buttonTextColor??AppColors.whiteColor)),
      ).marginSymmetric(horizontal: 10),
    );
  }
}
