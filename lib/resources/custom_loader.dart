
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


// Loader using getx
  showLoader(bool show) {
  if (show) {
    Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () async {
            // Return false to prevent the dialog from closing on back button press
            return false;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [

              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.5),
                  // borderRadius: BorderRadius.circular(4.0),
                  shape: BoxShape.circle,
                  // image: DecorationImage(image: AssetImage(AppAssets.loaderLogo)),
                ),
                child: const CircularProgressIndicator(color: AppColors.primaryColor,strokeWidth: 2,).marginAll(1),
              ),
              Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    // color: App.white,
                      shape: BoxShape.circle
                  ),
                  child: Image.asset(AppAssets.loaderLogo).marginAll(10)),
            ],
          ),
        ));
  } else {
    Get.back();
  }
}


