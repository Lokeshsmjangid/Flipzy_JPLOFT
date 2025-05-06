import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          addHeight(52),
          backAppBar(onTapBack: (){
            Get.back();
          },title: 'Order Traking'),
          // addHeight(20),

          Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addHeight(20),

                build_location_box(location: '1293 St. John Street,Lavistown'),
                addHeight(20),


                ...List.generate(2, (index){
                  return build_text_tile(title: '₦ 60,000');
                }),

                BorderedContainer(
                    padding: 20,
                    isBorder: false,
                    bGColor: AppColors.greenColor.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addHeight(10),
                        addText700('Price Details',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 16),
                        addHeight(12),
                        build_tile(title: 'Price (2 item)',subTitle: '₦ 90,000',subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        build_tile(title: 'Discount',subTitle: '₦ -2000',subTitleColor: AppColors.greenColor),

                        addHeight(12),
                        build_tile(title: 'Delivery Charges',subTitle: 'Free Delivery',subTitleColor: AppColors.greenColor),

                        addHeight(12),
                        continueButton(
                            child: build_tile(title: 'Total Amount',subTitle: '₦ 88,000',subTitleColor: Colors.black)),



                        addHeight(4),
                      ],
                    )
                ),
                addHeight(20),

                BorderedContainer(
                    radius: 1000,
                    child: Row(
                      children: [
                        Expanded(child: AppButton(buttonColor: AppColors.greenColor.withOpacity(0.1),
                            buttonTxtColor: AppColors.blackColor,buttonText: '₦ 88,000').marginSymmetric(horizontal: 4)),
                        Expanded(child: AppButton(buttonText: 'Place Order').marginSymmetric(horizontal: 4)),
                      ],
                    )
                ),
                addHeight(24),
              ],
            ).marginSymmetric(horizontal: 20),
          ))

        ],
      ),
    );
  }
  build_text_tile({ String? title,bool upperBorder = false,bool lowerBorder = false,void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: AppColors.appBgColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.containerBorderColor),

        ),
        child: Column(
          children: [
            Row(
              children: [

                // Divider(height: 0,),
                Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color(0xffD0E1EA),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle
                    ),
                    child: Image.asset(AppAssets.profileImage,fit: BoxFit.cover,)),
                addWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            constraints: BoxConstraints(
                                minWidth: 106,
                                maxWidth: 106
                            ),
                            child: addText500('${title}',fontSize: 16,fontFamily: 'Poppins',color: AppColors.blackColor)),
                        addWidth(20),
                        SvgPicture.asset(AppAssets.isFavouriteSelect,height: 13,width: 13),

                      ],
                    ),
                    addText500('Apple iPhone 16 ',fontSize: 12,fontFamily:'Poppins',color: AppColors.textColor2).marginOnly(bottom: 8),

                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.textLocationIcon,height: 12,width: 12,color: AppColors.blackColor,).marginOnly(right: 4),
                        addText500('USA',fontSize: 12,fontFamily:'Manrope',color: AppColors.blackColor)
                      ],
                    ).marginOnly(bottom: 8),


                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.primaryColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('4.4',fontSize: 11,fontFamily: 'Manrope',color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 12,vertical: 2),
                        ),
                        // Spacer(),
                        addWidth(12),
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
                              addText500('Remove',fontSize: 12,fontFamily: 'Manrope',color: AppColors.whiteColor),
                            ],
                          ).marginSymmetric(horizontal: 8,vertical: 2),
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

  build_location_box({String? location}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: AppColors.appBgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.containerBorderColor),

          ),
          child: Row(
            children: [
              addText500('Delivery to:',fontFamily: 'Manrope',fontSize: 12,color: AppColors.textFieldHintColor),
              addText500('$location',fontFamily: 'Manrope',fontSize: 13)
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: -12,


          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.primaryColor)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                addText500('Change',fontSize: 12,fontFamily: 'Manrope',color: AppColors.whiteColor),
              ],
            ).marginSymmetric(horizontal: 8,vertical: 2),
          ),)

      ],
    );
  }

  build_tile({String? title, String? subTitle, Color subTitleColor = AppColors.greenColor }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addText500('$title',fontFamily: 'Manrope',color: AppColors.textColor3,fontSize: 14),
        Container(
            constraints: BoxConstraints(maxWidth: 260),
            child: addText500('$subTitle',fontFamily: 'Manrope',color: subTitleColor,fontSize: 14))
      ],
    );
  }

  continueButton({void Function()? onTap,Widget? child}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: double.infinity,
        // constraints: const BoxConstraints(maxHeight: 36),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(100)),
        child: child,
      ),
    );
  }

}
