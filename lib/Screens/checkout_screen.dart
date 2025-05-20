import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/initiate_payment_repo.dart';
import 'package:flipzy/Api/repos/verify_payment_repo.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flipzy/dialogues/apply_coupon_success_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../custom_widgets/customAppBar.dart';
import 'location_screen/manual_location.dart';


class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.bgColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: IconButton(
            onPressed: (){Get.back(result: Get.find<CheckOutController>().counter);},
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "CheckOut",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),

      body: SafeArea(
        child: GetBuilder<CheckOutController>(
            init: CheckOutController(),
            builder: (logic) {
              return logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(
                  color: AppColors.secondaryColor))
                  : logic.response.data != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // addHeight(20),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addHeight(20),
                              build_location_box(
                                  location: '${logic.response.data != null
                                      ? logic.response.data?.shippingAddress
                                      ?.address
                                      : ''}', logic: logic),
                              addHeight(20),

                              ...List.generate(1, (index) {
                                return build_text_tile(
                                  logic: logic,
                                  index: index,
                                  title: '₦${logic.response.data!.product
                                      ?.price ?? '0'}',
                                  subtitle: '${logic.response.data!.product
                                      ?.productName?.capitalize ?? ''}',
                                  location: '${logic.response.data!
                                      .sellerAddress ?? ''}',
                                  // isfavIcon: logic.productList?.favoriteIcon??false,
                                  // image: index == 0 ? AppAssets.homeScreenIphone2 : AppAssets.homeScreenIphone1
                                  image: logic.response.data!.product
                                      ?.productImages != null &&
                                      logic.response.data!.product!
                                          .productImages!.isEmpty ? ApiUrls
                                      .productEmptyImgUrl : logic.response.data!
                                      .product?.productImages![0],

                                );
                              }),

                              SizedBox(
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width,
                                child: BorderedContainer(
                                    padding: 10,
                                    isBorder: false,
                                    bGColor: AppColors.greenColor.withOpacity(
                                        0.1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        // addHeight(4),
                                        addText700('SAVING CORNER',
                                            fontFamily: 'Manrope',
                                            color: AppColors.textColor3,
                                            fontSize: 16),
                                        addHeight(4),
                                        Column(

                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      borderRadius: BorderRadius
                                                          .circular(6)
                                                  ),
                                                  child: Image
                                                      .asset(
                                                    AppAssets.couponLogo,
                                                    height: 14,
                                                    width: 14,
                                                    color: Colors.white,)
                                                      .marginAll(6),
                                                ),
                                                addWidth(10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    if(logic.appliedCoupon ==
                                                        null)
                                                      addText500('Apply Coupon',
                                                          fontFamily: 'Manrope',
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 13),
                                                    if(logic.appliedCoupon !=
                                                        null)
                                                      addText600("'${logic
                                                          .appliedCoupon
                                                          ?.promoCode ??
                                                          ''}' applied",
                                                          fontFamily: 'Manrope',
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 13),
                                                    if(logic.appliedCoupon !=
                                                        null)
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(AppRoutes
                                                              .allCouponScreen,
                                                              arguments: {
                                                                'applied_coupon': logic
                                                                    .appliedCoupon,
                                                                'product_price': logic
                                                                    .response
                                                                    .data
                                                                    ?.productPrice,
                                                                'checkout_price': logic
                                                                    .response
                                                                    .data
                                                                    ?.totalAmount,
                                                              })?.then((value) {
                                                            if (value != null &&
                                                                value is List &&
                                                                value
                                                                    .isNotEmpty) {
                                                              log(
                                                                  'Selected Coupon: ${value[0]}');
                                                              logic
                                                                  .appliedCoupon =
                                                              value[0];
                                                              logic.update();
                                                              logic
                                                                  .fetchCheckoutData();
                                                            } else {
                                                              log(
                                                                  'Selected Coupon: kich nhi aaya');
                                                              logic
                                                                  .appliedCoupon =
                                                              null;
                                                              logic.update();
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            addText500(
                                                                'View all Coupons',
                                                                fontFamily: 'Manrope',
                                                                color: AppColors
                                                                    .containerBorderColor1,
                                                                fontSize: 13),
                                                            addWidth(8),
                                                            Icon(Icons
                                                                .arrow_forward_ios,
                                                                size: 14,
                                                                color: AppColors
                                                                    .containerBorderColor1)
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if(logic.appliedCoupon == null)
                                                  IconButton(
                                                    visualDensity: VisualDensity(
                                                        horizontal: -4,
                                                        vertical: -4),
                                                    icon: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 14),
                                                    onPressed: () {
                                                      Get.toNamed(AppRoutes
                                                          .allCouponScreen,
                                                          arguments: {
                                                            'applied_coupon': logic
                                                                .appliedCoupon,
                                                            'product_price': logic
                                                                .response.data
                                                                ?.productPrice,
                                                            'checkout_price': logic
                                                                .response.data
                                                                ?.totalAmount,
                                                          })?.then((value) {
                                                        if (value != null &&
                                                            value is List &&
                                                            value.isNotEmpty) {
                                                          log(
                                                              'Selected Coupon: ${value[0]}');
                                                          logic.appliedCoupon =
                                                          value[0];
                                                          logic.update();
                                                          logic
                                                              .fetchCheckoutData();
                                                        } else {
                                                          log(
                                                              'Selected Coupon: kich nhi aaya');
                                                        }
                                                      });
                                                    },), //
                                                if(logic.appliedCoupon != null)
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check, size: 16,
                                                        color: Colors.green,),
                                                      addText500('Applied',
                                                          fontFamily: 'Manrope',
                                                          color: Colors.green,
                                                          fontSize: 13),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),


                                      ],
                                    )
                                ),
                              ),
                              addHeight(10),
                              BorderedContainer(
                                  padding: 20,
                                  isBorder: false,
                                  bGColor: AppColors.greenColor.withOpacity(
                                      0.1),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      addHeight(10),
                                      addText700('Price Details',
                                          fontFamily: 'Manrope',
                                          color: AppColors.blackColor,
                                          fontSize: 16),
                                      addHeight(12),
                                      build_tile(title: 'Price (1 item)',
                                          subTitle: '₦${logic.response.data!
                                              .productPrice ?? '0'}',
                                          subTitleColor: AppColors.blackColor),

                                      addHeight(12),
                                      build_tile(title: 'Discount',
                                          subTitle: '₦ -${logic.response.data
                                              ?.discount ?? 0}',
                                          subTitleColor: AppColors.greenColor),

                                      addHeight(12),
                                      build_tile(title: 'Delivery Charges',
                                          subTitle: '${logic.response.data!
                                              .shippingCharge}',
                                          subTitleColor: AppColors.greenColor),

                                      addHeight(12),
                                      continueButton(
                                          child: build_tile(
                                              title: 'Total Amount',
                                              subTitle: '₦${logic.response.data!
                                                  .totalAmount}',
                                              subTitleColor: Colors.black)),
                                      addHeight(4),
                                    ],
                                  )
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: addText400(
                                      logic.productList?.isReturnAvailable ==
                                          false
                                          ? 'This product is not eligible for returns.  '
                                          : 'This product is eligible for returns.',
                                      color: logic.productList
                                          ?.isReturnAvailable == false
                                          ? AppColors.redColor
                                          : AppColors.greenColor,
                                      fontSize: 12,
                                      fontFamily: 'Manrope')).marginOnly(
                                  top: 10),

                              addHeight(20),

                              AppButton(
                                  buttonText: 'Place Order',
                                  buttonTxtColor: AppColors.blackColor,
                                  buttonColor: logic.response.data?.isDelivered == false ? AppColors.textFieldHintColor : null,
                                  onButtonTap: logic.response.data
                                      ?.isDelivered == false
                                      ? () {
                                    showToastError('${logic.response.message}');
                                  }
                                      : () {
                                    showLoader(true);
                                    getPayUrlApi(
                                        productId: logic.productList?.id,
                                        totalAmount: logic.response.data
                                            ?.totalAmount).then((value) {
                                      showLoader(false);
                                      if (value.status == true) {
                                        Get.toNamed(AppRoutes.paymentWebView,
                                            arguments: {
                                              'initial_url': value.data?.link ??
                                                  '',
                                              'product_id': logic.productList
                                                  ?.id})?.then((value) {
                                          log('call back result ${value}');
                                          if (value != null) {
                                            showLoader(true);
                                            verifyPaymentApi(isBoost: false,
                                                productId: logic.productList
                                                    ?.id,
                                                tx_ref: value['tx_ref'],
                                                shippingCharges: logic.response
                                                    .data?.shippingCharge,
                                                discount: logic.response.data
                                                    ?.discount).then((val) {
                                              showLoader(false);
                                              if (val.success == true) {
                                                showToast('${val.message}');
                                                Get.back();
                                              }
                                            });
                                          };
                                        });
                                      } else {
                                        showToastError('${value.message}');
                                      }
                                    });
                                  }
                              ),

                              addHeight(24),
                            ],
                          ).marginSymmetric(horizontal: 20)))

                ],
              )
                  : Center(child: addText600('No data found'));
            }),
      ),
    );
  }

  build_text_tile(
      { int? index, String? title, String? subtitle, String? location, String? image,
        bool upperBorder = false, bool isfavIcon = false, bool lowerBorder = false, void Function()? onTap, void Function()? remove,
        CheckOutController? logic}) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: CachedImageCircle2(
                        isCircular: false, imageUrl: image, fit: BoxFit.fill),
                  ),
                  // child: Image.asset(AppAssets.profileImage,fit: BoxFit.cover,)
                ),
                addHeight(8),
                addWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addText700('${title}', fontSize: 14,
                            fontFamily: '',
                            color: AppColors.blackColor),
                        /*addWidth(Get.width * 0.2),
                        SvgPicture.asset(AppAssets.greenFavourite,
                            color: isfavIcon
                                ? AppColors.primaryColor
                                : AppColors.containerBorderColor,
                            height: 13,
                            width: 13),*/


                      ],
                    ),
                    addText500('${subtitle}', fontSize: 10,
                        fontFamily: '',
                        color: AppColors.textColor2).marginOnly(bottom: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icon/locationic2.svg', height: 12,
                          width: 12,
                          color: AppColors.blackColor,).marginOnly(right: 4),
                        Container(
                          constraints: BoxConstraints(maxWidth: 100),
                          child: addText500('${location}', fontSize: 10,
                              fontFamily: 'Manrope',
                              color: AppColors.blackColor),
                        )
                      ],
                    ).marginOnly(bottom: 8),


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

                    if(logic!.productList?.stock == 'In Stock')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            logic.updateCounter(
                                true, logic.productList!.stockQuantity!);
                            logic.update();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.containerBorderColor,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.add, size: 18,).marginAll(4)),
                        ),
                        // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                        GetBuilder<CheckOutController>(builder: (logic) {
                          return addText500('${logic.counter}', fontSize: 14,
                              fontFamily: 'Manrope',
                              color: AppColors.blackColor);
                        }).marginSymmetric(horizontal: 8),
                        GestureDetector(
                          onTap: () {
                            logic.updateCounter(
                                false, logic.productList!.stockQuantity!);
                            logic.update();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.containerBorderColor,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.remove, size: 18,).marginAll(
                                  4)),
                        )
                      ],
                    ).marginOnly(left: 12,right: 12,top: 12),
                  ],
                ),

              ],
            ),
          ],
        ),
      ).marginOnly(bottom: 12),
    );
  }

  build_location_box({String? location, logic}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addText500('Delivery to: ', fontFamily: 'Manrope',
                  fontSize: 12,
                  color: AppColors.textFieldHintColor),
              Expanded(child: addText500(
                  '$location', fontFamily: 'Manrope', fontSize: 13))
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: -12,
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.allAddressScreen)?.then((value) {
                logic.fetchCheckoutData();
              });
            },
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
            ),
          ),)

      ],
    );
  }

  build_tile({String? title, String? subTitle, Color subTitleColor = AppColors
      .greenColor }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addText500('$title', fontFamily: '',
            color: AppColors.textColor3,
            fontSize: 14),
        Container(
            constraints: BoxConstraints(maxWidth: 260),
            child: addText500('$subTitle', fontFamily: '',
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
