import 'package:flipzy/Screens/help/contact_us.dart';
import 'package:flipzy/controllers/help_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpController>(
        init: HelpController(),
        builder: (cntrl) {
          return Scaffold(
            appBar: customAppBar(
              backgroundColor: AppColors.whiteColor,
              leadingWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3,
              leadingIcon: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_outlined,
                        color: AppColors.blackColor, size: 14,),
                      addText400("Back", color: AppColors.blackColor,
                          fontSize: 12,
                          fontFamily: 'Poppins'),
                    ],
                  ).marginOnly(left: 12)),
              centerTitle: true,
              titleTxt: "Help & Support",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: true,
            ),

            body: GetBuilder<HelpController>(builder: (logic) {
              return logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
                  : logic.model.data!=null && logic.model.data!.isNotEmpty
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: addText700("Need Help? (FAQs)",
                              fontFamily: 'Manrope',
                              maxLines: 2,
                              color: AppColors.blackColor,
                              fontSize: 20)),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: addText500(
                              "If you need assistance while completing your business profile, check out the frequently asked questions below. These will help you understand the importance of a complete profile and guide you through the process smoothly.",
                              color: AppColors.textColor1,
                              fontSize: 12,
                              fontFamily: 'Manrope')),
                    ),

                    SizedBox(height: 20,),

                    ...cntrl.model.data!.map((item) =>
                        GestureDetector(
                          onTap: () {
                            item.isSelect = !item.isSelect!;
                            cntrl.update();
                          },
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: item.isSelect == true ? AppColors
                                    .lightGreyColor : AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.greyColor)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addText500(
                                    "${item.question}", maxLines: 2,
                                    color: AppColors.blackColor,
                                    fontSize: 14,
                                    fontFamily: 'Manrope'),
                                Visibility(
                                    visible: item.isSelect!,
                                    child: SizedBox(height: 10,)),
                                Visibility(
                                    visible: item.isSelect!,
                                    child: addText500("${item.details}",
                                        color: AppColors.txtGreyColor,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                        ),),

                    SizedBox(height: 30,),
                    //Save
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: AppButton(
                        onButtonTap: () {
                          // Get.to(BusinessProfile());

                          Get.to(ContactUs());
                        },
                        buttonText: 'Contact Us', buttonTxtColor: AppColors
                          .blackColor,).marginSymmetric(horizontal: 4),
                    ),

                    SizedBox(height: 30,),

                    // ListView.builder(itemBuilder: itemBuilder)
                  ],
                ),
              )
                  : Center(child: addText400('No Data Found'));
            }),
          );
        });
  }
}
