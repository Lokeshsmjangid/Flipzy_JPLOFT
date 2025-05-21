
import 'dart:ui';

import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AboutUsDialog {
  static void show(BuildContext context,{void Function()? onTap,required String aboutUsDesc,required String pageTitle}) {
    showDialog(
      context: context,
      barrierColor: Color(0xff56716a).withOpacity(0.75),
      barrierDismissible: true,
      builder: (_) => AboutUsDialogWidget(onTap: onTap,aboutUsDesc:aboutUsDesc,pageTitle:pageTitle),
    );
  }
}

class AboutUsDialogWidget extends StatelessWidget {
  void Function()? onTap;
  String? pageTitle;
  String? aboutUsDesc;

  AboutUsDialogWidget({this.onTap, this.pageTitle, this.aboutUsDesc});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: AppColors.whiteColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height*0.9),
                // padding: const EdgeInsets.symmetric( horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.containerBorderColor),
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20), // Set the border radius
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      addHeight(60),
                      // addText500('${aboutUsDesc}',color: AppColors.textColor1,textAlign: TextAlign.justify,fontSize: 13,fontFamily: 'Manrope'),

                      Html(data: aboutUsDesc,style: {
                        'p': Style(fontSize: FontSize(13),fontWeight: FontWeight.w500,color: AppColors.textColor1,fontFamily: 'Manrope',textAlign: TextAlign.justify),
                      }),
                      addHeight(20),
                    ],
                  ),
                ),
              ),

              Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: SvgPicture.asset(AppAssets.cancelIcon,color: AppColors.whiteColor)),
                        addText700('${pageTitle??''}',textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor),
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: SvgPicture.asset(AppAssets.cancelIcon)),
                      ],
                    ).marginOnly(left: 12,right: 12,top: 15,bottom: 4),
                  ))
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
        width: 100,
        constraints: const BoxConstraints(maxHeight: 40),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText700('$buttonText',fontFamily: 'Manrope',fontSize: 14,color: buttonTextColor??AppColors.blackColor)),
      ).marginSymmetric(horizontal: 10),
    );
  }
}