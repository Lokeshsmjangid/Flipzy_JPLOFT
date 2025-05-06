import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/decline_order_repo.dart';
import 'package:flipzy/Api/repos/order_status_repo.dart';
import 'package:flipzy/Api/repos/refund_initiate_repo.dart';
import 'package:flipzy/Api/repos/refund_respond_repo.dart';
import 'package:flipzy/Screens/order_management_screens/order_mark_ship_screen.dart';
import 'package:flipzy/Screens/withdrawl/wallet_management.dart';
import 'package:flipzy/controllers/order_confirm_controller.dart';
import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/dialogues/decline_order_dialogue.dart';
import 'package:flipzy/dialogues/decline_order_success_dialogue.dart';
import 'package:flipzy/dialogues/refund_order_confirmation_dialogue.dart';
import 'package:flipzy/dialogues/refund_order_not_confirm_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: SafeArea(
        child: Column(
          children: [
            addHeight(20),
            backAppBar(onTapBack: () {
              Get.back();
            }),

            Expanded(child: GetBuilder<OrderConfirmController>(
                init: OrderConfirmController(),
                builder: (logic) {
              return logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                  : logic.response.data != null
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    addHeight(14),

                    SizedBox(
                        height: 200,
                        child: BorderedContainer(
                            padding: 0,
                            isBorder: false,
                            child: Center(
                                // child: Image.asset(AppAssets.orderMangeIphone).marginOnly(top: 12)
                                child: CachedImageCircle2(isCircular: false,imageUrl: logic.response.data![0].products!.productImages!.isNotEmpty?'${logic.response.data![0].products!.productImages![0]}':'${ApiUrls.productEmptyImgUrl}').marginOnly(top: 12)
                            ))),


                    addHeight(20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText700('₦${logic.response.data![0].products!.price}', fontFamily: '',
                            color: AppColors.blackColor,
                            fontSize: 24)),
                    Align(
                        alignment: Alignment.centerLeft, child: addText600(
                        '${logic.response.data![0].products!.productName?.capitalize??''}',
                        fontFamily: 'Manrope',
                        color: AppColors.textColor3,
                        fontSize: 18)),
                    addHeight(20),

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
                            build_tile(title: 'Price (1 iteam)',
                                subTitle: '₦ ${logic.response.data![0].products?.price??'0'}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Payment',
                                subTitle: '${logic.response.data![0].paymentMethod??""}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Discount',
                                subTitle: '-${logic.response.data![0].productDetails!.discount}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Delivery Charges',
                                subTitle: '${logic.response.data![0].shippingCharges??'0'}',
                                subTitleColor: AppColors.greenColor),



                            addHeight(12),
                            continueButton(
                                child: build_tile(title: 'Total Amount',
                                    subTitle: '₦ ${logic.response.data![0].totalAmount??0}',
                                    /*subTitle: '₦ ${logic.productTotal(
                                        discount: logic.response.data![0].productDetails!.discount??0,
                                        deliveryCharge: logic.response.data![0].shippingCharges??0,
                                      totalAmount: int.parse('${logic.response.data![0].totalAmount??0}')
                                    )}',*/

                                    subTitleColor: Colors.black)),


                            addHeight(4),
                          ],
                        )
                    ),
                    addHeight(16),
                    BorderedContainer(
                        padding: 20,
                        isBorder: false,
                        bGColor: AppColors.greenColor.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addHeight(10),
                            addText700('Details', fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 16),
                            addHeight(12),
                            build_tile(title: 'Name',
                                subTitle: '${logic.response.data![0].shippingAddress!.fullName?.capitalize}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Address',
                                subTitle: '${logic.response.data![0].shippingAddress!.address}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Contact No.',
                                subTitle: '${logic.response.data![0].shippingAddress!.mobileNumber}',
                                subTitleColor: AppColors.blackColor),

                            // addHeight(12),
                            // build_tile(title: 'Email Id',
                            //     subTitle: 'customer@gmail.com',
                            //     subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'delivery date'.capitalize,
                                subTitle: '${formatDate(dateTimeString: logic.response.data![0].estimatedDelivery!=null?logic.response.data![0].estimatedDelivery.toString():null)}',
                                subTitleColor: AppColors.blackColor),


                            addHeight(4),
                          ],
                        )
                    ),
                    addHeight(16),


                    BorderedContainer(
                        radius: 1000,
                        child: AppButton(
                            buttonColor: AppColors.secondaryColor,
                            buttonTxtColor: AppColors.blackColor,
                            onButtonTap: () {
                              showLoader(true);
                             /* changeOrderStatusApi(
                                  orderId: logic.orderId,
                                  orderStatus: 'Pending').then((value){
                                showLoader(false);
                                if(value.status==true){
                                  Get.find<OrderListController>().selectedTab=0;
                                  Get.find<OrderListController>().update();
                                  Get.find<OrderListController>().fetchOrderList();
                                  Get.back();
                                }
                              });*/

                              refundRespondApi(
                                  orderId: logic.orderId,
                                  action: 'accept').then((value){
                                showLoader(false);
                                if(value.status==true){
                                  Get.find<OrderListController>().selectedTab=0;
                                  Get.find<OrderListController>().update();
                                  Get.find<OrderListController>().fetchOrderList();
                                  Get.back();
                                }
                              });
                            },
                            buttonText: 'Confirm Order').marginSymmetric(
                            horizontal: 4)
                    ),

                    addHeight(10),

                    BorderedContainer(
                        radius: 1000,
                        child: AppButton(
                            buttonColor: AppColors.bgColor,
                            buttonTxtColor: AppColors.blackColor,
                            onButtonTap: () {
                              Get.back();
                              DeclineOrderDialog.show(context,
                                  msgCtrl: logic.declineMessage,
                                  onTap: (){
                                showLoader(true);
                                refundRespondApi(
                                    orderId: logic.orderId,
                                    action: 'reject',Decline: 'Seller',
                                    // orderStatus: 'Refund',
                                    message: logic.declineMessage.text).then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    Future.microtask((){
                                      Get.back();
                                      DeclineOrderSuccessDialog.show(Get.context!);
                                    });
                                  }
                                });


                                /*declinedOrderApi(
                                    orderId: logic.orderId,
                                    orderStatus: 'Refund',
                                    message: logic.declineMessage.text).then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    Future.microtask((){
                                      Get.back();
                                      DeclineOrderSuccessDialog.show(Get.context!);
                                    });
                                  }
                                });*/

                              });
                            },
                            buttonText: 'Decline Order').marginSymmetric(
                            horizontal: 4)
                    ),
                    addHeight(24)
                  ],
                ).marginSymmetric(horizontal: 16),
              )
                  : Center(child: addText600('No Orders found'));
            }))


          ],
        ),
      ),
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

  build_tile({String? title, String? subTitle, Color subTitleColor = AppColors
      .greenColor }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addText500('$title', fontFamily: 'Manrope',
            color: AppColors.textColor3,
            fontSize: 14),
        Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(Get.context!).width*0.4),
            child: addText500('$subTitle', fontFamily: '',
                color: subTitleColor,
                fontSize: 14))
      ],
    );
  }
}
