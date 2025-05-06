import 'dart:ui';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/order_detail_response.dart';
import 'package:flipzy/Api/repos/give_feedback_repo.dart';
import 'package:flipzy/Api/repos/give_review_repo.dart' show giveRatingApi;
import 'package:flipzy/Screens/buyer_return_product_screen.dart';
import 'package:flipzy/Screens/order_management_screens/steper_screen.dart';
import 'package:flipzy/controllers/order_detail_controller.dart';
import 'package:flipzy/dialogues/dont_agree_dialogue.dart';
import 'package:flipzy/dialogues/feedback_thanks_dialogue.dart';
import 'package:flipzy/dialogues/purchase_thanks_dialogue.dart';
import 'package:flipzy/dialogues/review_dialogue.dart' show ReviewDialog;
import 'package:flipzy/dialogues/setisfied_product_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {


  TextEditingController feedbackComment = TextEditingController();
  @override


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            addHeight(20),
            backAppBar(onTapBack: () {
              Get.back();
            }, title: 'Order Details'),
            // addHeight(20),

            Expanded(child: GetBuilder<OrderDetailController>(
                init: OrderDetailController(),
                builder: (logic) {

              return logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                  : logic.response.data!=null
                  ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addHeight(20),

                    build_location_box(
                        data: logic.response.data![0],
                        location: '1293 St. John Street,Lavistown',
                        orderId: logic.orderId,
                        productName: logic.response.data![0].products!.productName,
                        price: logic.response.data![0].totalAmount.toString(),

                    ),
                    addHeight(20),


                    build_steper(data: logic.response.data![0]),
                    addHeight(20),

                    // Container(
                    //   // color: Colors.red,
                    //   child: EasyStepper(
                    //     fitWidth: true,
                    //
                    //     internalPadding: 200,
                    //     // Which step is currently active (or last completed).
                    //     activeStep: activeStep,
                    //
                    //     // Make the timeline vertical.
                    //     direction: Axis.vertical,
                    //
                    //     // Overall line color and thickness.
                    //     // lineColor: Colors.black,
                    //     borderThickness: 2,
                    //
                    //     // Shape and size of each step.
                    //     stepShape: StepShape.circle,
                    //     stepRadius: 18,
                    //
                    //     // Colors for different step states.
                    //     // You can fine-tune these to match your design.
                    //     finishedStepBackgroundColor: Colors.green.shade800,
                    //     activeStepBackgroundColor: Colors.green.shade800,
                    //     unreachedStepBackgroundColor: Colors.white,
                    //
                    //     finishedStepBorderColor: Colors.green.shade800,
                    //     activeStepBorderColor: Colors.green.shade800,
                    //     unreachedStepBorderColor: Colors.green.shade800,
                    //
                    //     // Remove any loading animation (if you prefer a simple style).
                    //     showLoadingAnimation: true,
                    //     alignment: Alignment.topLeft,
                    //     textDirection: TextDirection.rtl,
                    //
                    //
                    //
                    //     // Define each step in the timeline.
                    //     steps: [
                    //       // 1) Confirm Order
                    //       EasyStep(
                    //         // The circular icon for this step.
                    //         customStep: const Icon(
                    //           Icons.local_shipping,  // Replace with your own asset if desired
                    //           color: Colors.white,
                    //           size: 20,
                    //         ),
                    //         // Text displayed beside (or under) the step icon.
                    //         customTitle: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'Confirm Order',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //                 // If this step is reached or past, show normal text,
                    //                 // otherwise grey it out.
                    //                 color: activeStep >= 0 ? Colors.black : Colors.grey,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 4),
                    //             Text(
                    //               'Booking Date : 28/01/2025',
                    //               style: TextStyle(
                    //                 fontSize: 14,
                    //                 color: activeStep >= 0 ? Colors.black : Colors.grey,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //
                    //       // 2) Order Packed
                    //       EasyStep(
                    //         customStep: const SizedBox.shrink(), // No icon circle, or use a smaller icon if you wish
                    //         customTitle: Text(
                    //           'Order Packed',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: activeStep >= 1 ? Colors.black : Colors.grey,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       // 3) Out For Delivery
                    //       EasyStep(
                    //         customStep: const SizedBox.shrink(),
                    //         customTitle: Text(
                    //           'Out Of Delivery',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: activeStep >= 2 ? Colors.black : Colors.grey,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       // 4) Expected Delivery
                    //       EasyStep(
                    //         customStep: const Icon(
                    //           Icons.home_filled, // Replace with your own asset if desired
                    //           color: Colors.white,
                    //           size: 20,
                    //         ),
                    //         customTitle: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'Expected Delivery',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: activeStep >= 3 ? Colors.black : Colors.grey,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 4),
                    //             Text(
                    //               'Delivery Date : 05/02/2025',
                    //               style: TextStyle(
                    //                 fontSize: 14,
                    //                 color: activeStep >= 3 ? Colors.black : Colors.grey,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //
                    //     // Called whenever a step is tapped (if you allow step tapping).
                    //     onStepReached: (index) {
                    //       setState(() {
                    //         activeStep = index;
                    //       });
                    //     },
                    //   ),
                    // ),

                    // EasyStepper(
                    //   activeStep: activeStep,
                    //   // lineLength: 50,
                    //   stepShape: StepShape.circle,
                    //   direction: Axis.vertical,
                    //   stepBorderRadius: 10,
                    //   borderThickness: 3,
                    //   activeStepBorderType: BorderType.normal,
                    //   lineStyle: LineStyle(lineType: LineType.normal) ,
                    //   enableStepTapping: false,
                    //
                    //   // fitWidth: true,
                    //   // activeStepTextColor: AppColors.primaryColor,
                    //   // maxReachedStep: 3,
                    //   // defaultStepBorderType: BorderType.normal,
                    //   // padding: EdgeInsets.all(5.0),
                    //   stepRadius: 28,
                    //   finishedStepBorderColor: Colors.deepOrange,
                    //   finishedStepTextColor: Colors.deepOrange,
                    //   finishedStepBackgroundColor: Colors.deepOrange,
                    //   activeStepIconColor: Colors.deepOrange,
                    //   showLoadingAnimation: false,
                    //   steps: [
                    //     EasyStep(
                    //       customStep: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //         child: Opacity(
                    //           opacity: activeStep >= 0 ? 1 : 0.3,
                    //           child:  SvgPicture.asset(AppAssets.bottomNav3,height: 14,width: 14, color: AppColors.blackColor ),
                    //           // child: Image.asset('assets/1.png'),
                    //         ),
                    //       ),
                    //       // customTitle: const Text(
                    //       //   'Dash 1',
                    //       //   textAlign: TextAlign.center,
                    //       // ),
                    //     ),
                    //     EasyStep(
                    //       customStep: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //         child: Opacity(
                    //           opacity: activeStep >= 1 ? 1 : 0.3,
                    //           child: Image.asset('assets/2.png'),
                    //         ),
                    //       ),
                    //       customTitle: const Text(
                    //         'Dash 2',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     EasyStep(
                    //       customStep: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //         child: Opacity(
                    //           opacity: activeStep >= 2 ? 1 : 0.3,
                    //           child: Image.asset('assets/3.png'),
                    //         ),
                    //       ),
                    //       customTitle: const Text(
                    //         'Dash 3',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     EasyStep(
                    //       customStep: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //         child: Opacity(
                    //           opacity: activeStep >= 3 ? 1 : 0.3,
                    //           child: Image.asset('assets/4.png'),
                    //         ),
                    //       ),
                    //       customTitle: const Text(
                    //         'Dash 4',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //     EasyStep(
                    //       customStep: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //         child: Opacity(
                    //           opacity: activeStep >= 4 ? 1 : 0.3,
                    //           child: Image.asset('assets/5.png'),
                    //         ),
                    //       ),
                    //       customTitle: const Text(
                    //         'Dash 5',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ],
                    //   onStepReached: (index) => () {
                    //     activeStep = index ;
                    //     setState(() {
                    //
                    //     });
                    //   },
                    // ),


                    // ...List.generate(2, (index){
                    //   return build_text_tile(title: '₹ 60,000');
                    // }),

                    BorderedContainer(
                        padding: 20,
                        isBorder: false,
                        bGColor: AppColors.greenColor.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // addHeight(5),
                            addText700('Price Details', fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 16),
                            addHeight(12),
                            build_tile(
                                // title: 'Price (2 item)',
                                title: 'Price',
                                subTitle: '₦${logic.response.data![0].products?.price.toString()}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Discount',
                                subTitle: '₦ -${logic.response.data![0].productDetails!.discount??0}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Delivery Charges',
                                subTitle: '${logic.response.data![0].shippingCharges??0}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            continueButton(
                                child: build_tile(title: 'Total Amount',
                                    subTitle: '₦ ${logic.response.data![0].totalAmount??0}',
                                    /*subTitle: '₦ ${logic.productTotal(
                                        totalAmount: int.parse('${logic.response.data![0].totalAmount??0}'),
                                        discount: logic.response.data![0].productDetails!.discount!,
                                        deliveryCharge: logic.response.data![0].productDetails!.deliveryCharge!
                                    )}',*/
                                    subTitleColor: Colors.black)),


                            addHeight(4),
                          ],
                        )
                    ),
                    addHeight(2.h),

                    if(logic.response.data![0].refundStatus?.toLowerCase() != 'completed' )
                      AppButton(
                        onButtonTap: () {
                          ReviewDialog.show(context,onTap: () {

                            showLoader(true);
                            giveRatingApi(productId: logic.orderId,
                                userDescription: logic.ratingCtrl.text,userRating: logic.initialRating).then((value){
                              showLoader(false);
                              if(value.status==true){
                                Get.back();
                                showToast('${value.message}');
                              }
                            });
                          },reviewCtrl: logic.ratingCtrl,
                              initialRating: logic.initialRating);
                        },
                        buttonText: 'Rate this product',
                        // buttonText: 'Cancel Order',
                        isPrefixIcon: false,
                        buttonTxtColor: AppColors.blackColor,),

                      // if(logic.response.data![0].isReturnAvailable==true)
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>BuyerReturnReasonScreen(orderId:logic.orderId));
                          // SetisfiedProductDialog.show(context,
                          //     onTap1: () {
                          //       Get.back();
                          //       PurchaseThanksDialog.show(context);
                          //     }, onTap2: () {
                          //       Get.back();
                          //       DontAgreeDialog.show(context, msgCtrl: feedbackComment,onTap: () {
                          //
                          //         showLoader(true);
                          //         giveFeedBackApi(productId: logic.orderId,userDescription: feedbackComment.text).then((value){
                          //           showLoader(false);
                          //           if(value.status==true){
                          //             Future.microtask(() {
                          //               FeedbackThanksDialog.show(Get.context!);
                          //             });
                          //           }
                          //         });
                          //
                          //
                          //
                          //       });
                          //     });
                        },
                        child: Container(
                          // color: Colors.red,
                          child: addText400('Any Problem with this product',
                              decoration: TextDecoration.underline,color: AppColors.blueColor1).marginAll(10),
                        ),
                      ),
                      
                      
                      
                      
                    addHeight(2.h),
                  ],
                ).marginSymmetric(horizontal: 20),
              ) : Center(child: addText600('No Orders found'));
            })),

          ],
        ),
      ),
    );
  }

  build_location_box({Datum? data,String? location,String? productName,String? orderId,String? price}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: AppColors.appBgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.containerBorderColor),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.09,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                // margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedImageCircle2(
                      isCircular: true,
                      imageUrl: data!.products!.productImages!.isNotEmpty?'${data.products!.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),
                  // child: Image.asset(AppAssets.homeScreenIphone1),
                  // child: Image.network(
                  //   AppAssets.demoIphoneImageUrl,
                  //   // "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                  //   // width: 50, height: 50,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              SizedBox(width: 10,),
              addText500('${productName?.capitalize??''}', fontFamily: 'Manrope',
                  fontSize: 12,
                  color: AppColors.blackColor),
              Spacer(),
             /* Icon(Icons.arrow_forward_ios_sharp, color: AppColors.blackColor,
                size: 20,)*/
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.greenLightColor,
                ),
                child: addText400(
                    "${data.orderStatus}", color: AppColors.blackColor, fontSize: 12),
              ),

            ],
          ),

          Row(
            children: [
              /*Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.greenLightColor,
                ),
                child: addText400(
                    "${data.orderStatus}", color: AppColors.blackColor, fontSize: 12),
              ),
              Spacer(),*/
              addText700("₦${price}", fontSize: 15,fontFamily: '')
            ],
          ),
          addHeight(2),
          addText500('Order Id :${orderId}', fontFamily: 'Manrope',
              fontSize: 12,
              color: AppColors.blackColor),


          // if(reason!=null )
          // addText500('Reason: ${reason}').marginOnly(top: 10)
        ],
      ),
    );
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

  build_steper({Datum? data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.darkGreenColor,
                  shape: BoxShape.circle),
              child: ClipRRect(
                // stepData.content['icon']
                child: SvgPicture.asset(
                  AppAssets.shippingConfirmTruck, color: AppColors.whiteColor,),
              ),
            ).marginOnly(bottom: 2),
            addWidth(14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                addText600(
                    'confirm order'.capitalizeFirst.toString(), fontSize: 14,
                    fontFamily: 'Manrope'),
                addText500('Booking Date :${formatDate(dateTimeString: data!.productDetails!.createdAt!=null? data.productDetails!.createdAt.toString():null)}', fontSize: 10,
                    fontFamily: 'Manrope')
              ],
            ),


          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: data.declinedBy!=null && data.declinedBy!.isNotEmpty?70:200,
              width: 1.5,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ).marginSymmetric(horizontal: 16),

            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                  ),
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                  ),
                )),

            if(data.declinedBy?.toLowerCase() !='seller')
            Positioned(
              top: 20,
              // top: 60,
              left: 50,
              child: addText500('Order packed'.capitalizeFirst.toString(),
                  color: data.declinedBy?.toLowerCase() !='seller' && data.orderStatus?.toLowerCase()=='processing'?AppColors.blackColor:AppColors.greyColor),),
            if(data.declinedBy?.toLowerCase() !='seller')
            Positioned(
              bottom: 90,
              left: 50,
              child: addText500('Shipped'.capitalizeFirst.toString(),
                  color:data.orderStatus?.toLowerCase()=='shipped'?AppColors.blackColor:AppColors.greyColor),),

            if(data.declinedBy?.toLowerCase() !='seller')
              Positioned(
                // bottom: 60,
                bottom: 20,
                left: 50,
                child: addText500('out for delivery'.capitalizeFirst.toString(),
                    color: data.orderStatus?.toLowerCase()=='InTransit'.toLowerCase()?AppColors.blackColor:AppColors.greyColor),),
                    // color: data.orderStatus?.toLowerCase()=='Out For Delivery'.toLowerCase()?AppColors.blackColor:AppColors.greyColor),),

          ],
        ),
        Row(
          children: [
            Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  shape: BoxShape.circle),
              child: ClipRRect(
                // stepData.content['icon']
                child: SvgPicture.asset(
                  AppAssets.expectedTrackTruck, color: AppColors.whiteColor,),
              ),
            ).marginOnly(top: 2),
            addWidth(14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if(data.declinedBy?.toLowerCase()=='seller' || data.declinedBy?.toLowerCase()=='user')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addText600('decline by ${data.declinedBy??''}'.capitalizeFirst.toString(),
                        fontSize: 14, fontFamily: 'Manrope'),

                    addText500('Reason : ${data.refundReason}', fontSize: 10,
                        color: AppColors.blackColor,
                        fontFamily: 'Manrope')
                    /*addText600('expected delivery'.capitalizeFirst.toString(),
                        fontSize: 14, fontFamily: 'Manrope'),
                    addText500('Delivery Date :${formatDate(dateTimeString: data.estimatedDelivery!=null?data.estimatedDelivery.toString():null)}', fontSize: 10,
                        color: AppColors.blackColor,
                        fontFamily: 'Manrope')*/
                  ],
                ),
                if(data.declinedBy!=null && data.declinedBy!.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addText600('expected delivery'.capitalizeFirst.toString(),
                        fontSize: 14, fontFamily: 'Manrope'),
                    // addText500('Delivery Date :${formatDate(dateTimeString: data.estimatedDelivery!=null?data.estimatedDelivery.toString():null)}', fontSize: 10,
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width*0.7
                      ),
                      child: addText500('The product is typically delivered within 3 to 4 days.', fontSize: 10,
                          color: AppColors.blackColor,
                          fontFamily: 'Manrope'),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),

        if(data.declinedBy!=null && data.declinedBy!.isNotEmpty)
          Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                  )),
              Container(
                height: 70,
                width: 1.5,
                decoration: BoxDecoration(
                    color: Colors.black
                ),
              ).marginSymmetric(horizontal: 16),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                  )),
            ],
          ).marginOnly(top: 2),
        if(data.declinedBy!=null && data.declinedBy!.isNotEmpty)
        Row(
          children: [
            Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle),
              child: ClipRRect(
                // stepData.content['icon']
                child: Image.asset(
                  AppAssets.couponAppliedLogo, color: AppColors.whiteColor,),
              ),
            ).marginOnly(top: 2),
            addWidth(14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addText600('refund ${data.refundStatus}'.capitalizeFirst.toString(),
                    fontSize: 14, fontFamily: 'Manrope'),

              ],
            ),


          ],
        ),
      ],
    );
  }
}
