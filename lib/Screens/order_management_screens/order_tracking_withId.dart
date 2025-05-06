import 'package:flipzy/Screens/order_management_screens/order_history_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_detail_screen.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../custom_widgets/CustomTextField.dart';

class OrderTrackingWithId extends StatelessWidget {
  const OrderTrackingWithId({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
              addText400("Back", color: AppColors.blackColor,fontFamily: 'Poppins',fontSize: 12),
            ],
          ).marginOnly(left: 12),
        ),
        centerTitle: true,
        titleTxt: "Order Tracking",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        actionItems: [
        ],
        bottomLine: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            addHeight(14),
            CustomTextField(
              fillColor: AppColors.whiteColor,
              hintText: 'Enter Order Id',
              borderRadius: 30,
              suffixIcon: Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Icon(Icons.search,color: Colors.black,),
              ).marginOnly(right: 10),
            ).marginSymmetric(horizontal: 16),

            Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppButton (
                  onButtonTap: () {
                    Get.toNamed(AppRoutes.orderDetailScreen);
                  },
                  buttonText: 'Track Order',
                buttonTxtColor: AppColors.blackColor,
              ),
            ),

            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
