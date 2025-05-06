import 'package:flipzy/Screens/cart_screen.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SellerTwoProfileScreen extends StatelessWidget {
  const SellerTwoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,),
              addText400("Back", color: AppColors.blackColor),
            ],
          ),
        ),
        centerTitle: true,
        titleTxt: "Amelia-Rose",
        titleColor: AppColors.blackColor,
        titleFontSize: 18,
        actionItems: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppAssets.searchIcon, height: 20, width: 20,)
          ),
        ],
        bottomLine: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // addHeight(20),

            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // addHeight(20),
                  //
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.more_vert)),
                  addHeight(20),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // height: Get.height * 0.22,
                        width: Get.width ,
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: 55,),
                        // padding: EdgeInsets.symmetric(vertical: 40),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          // margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            // color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.greyColor, width: 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.starImage),
                                      addWidth(4),
                                      addText700("4.4",fontFamily: 'Manrope',fontSize: 18),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Ratings",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/locationic2.svg'),
                                      addWidth(4),
                                      addText700("USA",fontFamily: 'Manrope',fontSize: 18),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Location",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.drawerOT),
                                      addWidth(4),
                                      addText700("125",fontFamily: 'Manrope',fontSize: 18),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Order Served",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                            ],
                          ).marginOnly(top: 50),
                        ),
                      ),

                      Positioned(
                        // top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Color(0xffD0E1EA),
                                // borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.circle
                            ),
                            child: Image.asset(AppAssets.notificationProfileIC,fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),

                  addHeight(20),

        // Withdrawal History
                  ...List.generate(10, (index){
                    return build_text_tile(title: '₦ 60,000',onTap: (){
                      Get.back();
                    });
                  })
                ],
              ).marginSymmetric(horizontal: 20),
            ))

          ],
        ),
      ),
    );
  }
  build_text_tile({ String? title,bool upperBorder = false,bool lowerBorder = false,void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: AppColors.appBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.containerBorderColor),

        ),
        child: Column(
          children: [
            Row(
              children: [

                // Divider(height: 0,),
                Container(
                    height: 96,
                    width: 126,
                    decoration: BoxDecoration(
                        color: Color(0xffD0E1EA),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(AppAssets.homeScreenIphone2, fit: BoxFit.fill,),
                      // child: Image.network(AppAssets.demoIphoneImageUrl, fit: BoxFit.cover,),
                    ),
                    // child: Image.asset(AppAssets.profileImage,fit: BoxFit.cover,)
                ),
                addWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addText700('${title}',fontSize: 14,fontFamily: 'Manrope',color: AppColors.blackColor),

                        // Container(
                        //     // constraints: BoxConstraints(
                        //     //     minWidth: 106,
                        //     //     maxWidth: double.infinity,
                        //     // ),
                        //     child: addText500('${title}',fontSize: 16,fontFamily: 'Poppins',color: AppColors.blackColor)),
                        addWidth(Get.width*0.2),
                        SvgPicture.asset(AppAssets.greenFavourite, color: AppColors.primaryColor, height: 13,width: 13),

                      ],
                    ),
                    addText500('Apple iPhone 16 ',fontSize: 10,fontFamily:'Manrope',color: AppColors.textColor2).marginOnly(bottom: 8),

                    Row(
                      children: [
                        SvgPicture.asset('assets/icon/locationic2.svg',height: 12,width: 12,color: AppColors.blackColor,).marginOnly(right: 4),
                        addText500('USA',fontSize: 10,fontFamily:'Manrope',color: AppColors.blackColor)
                      ],
                    ).marginOnly(bottom: 8),


                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.blackColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppAssets.starImage),
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('4.4',fontSize: 10,fontFamily: 'Manrope',color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 12,vertical: 2),
                        ),
                        // Spacer(),
                        addWidth(Get.width*0.1),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.primaryColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('View',fontSize: 10,fontFamily: 'Manrope',color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 16,vertical: 2),
                        ),

                      ],
                    )
                  ],
                ),


              ],
            ),
          ],
        ),
      ).marginOnly(bottom: 12),
    );

  }

}
