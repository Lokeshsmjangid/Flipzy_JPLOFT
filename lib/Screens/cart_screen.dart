import 'package:flipzy/Api/repos/delete_from_cart.dart';
import 'package:flipzy/controllers/cart_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../custom_widgets/customAppBar.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery
            .of(context)
            .size
            .width * 0.3,
        leadingIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,
                size: 14,),
              addText400("Back", color: AppColors.blackColor,
                  fontSize: 12,
                  fontFamily: 'Poppins'),
            ],
          ).marginOnly(left: 12),
        ),
        centerTitle: true,
        titleTxt: "My Cart",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        actionItems: [
        ],
        bottomLine: true,
      ),
      body: SafeArea(
        child: GetBuilder<CartController>(
            init: CartController(),
            builder: (logic) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // addHeight(20),


              Expanded(child:logic.isDataLoading?
              Center(
                child: CircularProgressIndicator(color: AppColors.secondaryColor),
              ): logic.response.data!=null && logic.response.data!.products!.isNotEmpty
                  ? SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addHeight(20),

                    build_location_box(location: '1293 St. John Street,Lavistown'),
                    addHeight(20),


                    ...List.generate(logic.response.data!.products!.length, (index) {
                      return build_text_tile(index: index,
                          title: '₦ ${logic.itemTotalPrice(logic.response.data!.products![index].price, logic.response.data!.products![index].quantity)}',
                          subtitle: '${logic.response.data!.products![index].productName}',
                          isfavIcon: logic.response.data!.products![index].isfavIcon!,
                          // image: index == 0 ? AppAssets.homeScreenIphone2 : AppAssets.homeScreenIphone1
                        image: logic.response.data!.products![index].images![0],
                        remove: (){
                        showLoader(true);
                          removeFromCartApi(cartId: logic.response.data!.products![index].id).then((value){
                            showLoader(false);
                            if(value.status==true){
                              showToast('${value.message}');
                            }
                          });
                        }

                      );
                    }),

                    BorderedContainer(
                        padding: 20,
                        isBorder: false,
                        bGColor: AppColors.greenColor.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addHeight(10),
                            addText700('Price Details', fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 16),
                            addHeight(12),
                            build_tile(title: 'Price (${logic.response.data!.products!.length} item)',
                                subTitle: '₦ ${logic.response.data!.totalAmount}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Discount',
                                subTitle: '₦ -${logic.response.data!.discount}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Delivery Charges',
                                subTitle: '${logic.response.data!.deliveryCharges}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            continueButton(
                                child: build_tile(title: 'Total Amount',
                                    subTitle: '₦ ${logic.response.data!.totalAmount}',
                                    subTitleColor: Colors.black)),
                            addHeight(4),
                          ],
                        )
                    ),
                    addHeight(20),

                    AppButton(
                        buttonText: 'Place Order', buttonTxtColor: AppColors
                        .blackColor, onButtonTap: () {
                      // Get.to(OrderTrackingScreen());
                    }),

                    addHeight(24),
                  ],
                ).marginSymmetric(horizontal: 20))
                  : Center(child: addText600('Cart is empty'),))

            ],
          );
        }),
      ),
    );
  }

  build_text_tile(
      { int? index, String? title, String? subtitle, String? image, bool upperBorder = false,bool isfavIcon = false, bool lowerBorder = false, void Function()? onTap, void Function()? remove}) {
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
                  height: 96,
                  width: 126,
                  decoration: BoxDecoration(
                      color: Color(0xffD0E1EA),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // child: Image.asset('$image', fit: BoxFit.cover,),
                    child: CachedImageCircle2(isCircular: false,imageUrl: image),
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
                        addText700('${title}', fontSize: 14,
                            fontFamily: 'Manrope',
                            color: AppColors.blackColor),

                        // Container(
                        //     // constraints: BoxConstraints(
                        //     //     minWidth: 106,
                        //     //     maxWidth: double.infinity,
                        //     // ),
                        //     child: addText500('${title}',fontSize: 16,fontFamily: 'Poppins',color: AppColors.blackColor)),
                        addWidth(Get.width * 0.3),
                        SvgPicture.asset(AppAssets.greenFavourite,
                            color: isfavIcon
                                ? AppColors.primaryColor
                                : AppColors.containerBorderColor,
                            height: 13,
                            width: 13),

                      ],
                    ),
                    addText500('${subtitle}', fontSize: 10,
                        fontFamily: 'Manrope',
                        color: AppColors.textColor2).marginOnly(bottom: 8),

                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/locationic2.svg', height: 12,
                          width: 12,
                          color: AppColors.blackColor,).marginOnly(right: 4),
                        addText500('USA', fontSize: 10,
                            fontFamily: 'Manrope',
                            color: AppColors.blackColor)
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
                              addText500('4.4', fontSize: 10,
                                  fontFamily: 'Manrope',
                                  color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 12, vertical: 2),
                        ),
                        // Spacer(),
                        addWidth(24),
                        GestureDetector(
                          onTap: remove,
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
                                addText500('Remove', fontSize: 10,
                                    fontFamily: 'Manrope',
                                    color: AppColors.blackColor),
                              ],
                            ).marginSymmetric(horizontal: 16, vertical: 2),
                          ),
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
              addText500('Delivery to:', fontFamily: 'Manrope',
                  fontSize: 12,
                  color: AppColors.textFieldHintColor),
              addText500('$location', fontFamily: 'Manrope', fontSize: 13)
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
                addText500('Change', fontSize: 12,
                    fontFamily: 'Manrope',
                    color: AppColors.blackColor),
              ],
            ).marginSymmetric(horizontal: 8, vertical: 2),
          ),)

      ],
    ).marginSymmetric(horizontal: 20);
  }

  build_tile({String? title, String? subTitle, Color subTitleColor = AppColors
      .greenColor }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addText500('$title', fontFamily: 'Manrope',
            color: AppColors.textColor3,
            fontSize: 14),
        Container(
            constraints: BoxConstraints(maxWidth: 260),
            child: addText500('$subTitle', fontFamily: 'Manrope',
                color: subTitleColor,
                fontSize: 14))
      ],
    );
  }

  continueButton({void Function()? onTap, Widget? child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
