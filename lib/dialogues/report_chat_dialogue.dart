
import 'dart:ui';

import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportChatDialogue {
  static void show(BuildContext context,{void Function()? onTap,TextEditingController?msgCtrl,bool? isChat }) {
    showDialog(
      context: context,
      barrierColor: Color(0xff56716a).withOpacity(0.75),
      barrierDismissible: true,
      builder: (_) => ReportChatDialogueWidget(onTap: onTap,msgCtrl: msgCtrl,isChat: isChat,),
    );
  }
}

class ReportChatDialogueWidget extends StatelessWidget {
  void Function()? onTap;
  TextEditingController? msgCtrl;
  bool? isChat;

  ReportChatDialogueWidget({this.onTap,this.msgCtrl,this.isChat=false});


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
                    // SvgPicture.asset(AppAssets.deleteUserPopupImage,height: 100,width: 100,).marginAll(15),

                    addText700('We’re Sorry for Your Experience',textAlign: TextAlign.center,fontFamily: 'Manrope',fontSize: 20,color: AppColors.blackColor).marginAll(15),



                    addText500('"Please Describe why are you reporting this ${isChat==true?"person":"product"}"',
                        fontFamily: 'Manrope',fontSize: 13,textAlign: TextAlign.center,color: AppColors.textColor1).marginSymmetric(horizontal: 10),


                    addHeight(20),

                    
                    
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500('Reason for report'.capitalize.toString(),fontFamily: 'Manrope',fontSize: 14)).marginSymmetric(horizontal: 10),
                    addHeight(6),
                    CustomTextField(
                      controller: msgCtrl,
                      hintText: 'Enter reason for your reporting...',
                      maxLines: 3).marginSymmetric(horizontal: 10),


                    addHeight(16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: continueButton(buttonText: 'Report',onTap: onTap,color: AppColors.primaryColor),),

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
