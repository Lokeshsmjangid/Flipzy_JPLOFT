import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/order_status_repo.dart';
import 'package:flipzy/Screens/withdrawl/wallet_management.dart';
import 'package:flipzy/controllers/order_change_status_controller.dart';
import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderMarkShipScreen extends StatefulWidget {
  const OrderMarkShipScreen({super.key});

  @override
  State<OrderMarkShipScreen> createState() => _OrderMarkShipScreenState();
}

class _OrderMarkShipScreenState extends State<OrderMarkShipScreen> {



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

            Expanded(child: GetBuilder<OrderChangeStatusController>(
                init: OrderChangeStatusController(),
                builder: (logic) {
              return logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                  : logic.response.data!=null
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: CachedImageCircle2(
                                      imageUrl: logic.response.data![0].products!.productImages!.isNotEmpty?'${logic.response.data![0].products!.productImages![0]}':'${ApiUrls.productEmptyImgUrl}',
                                      isCircular: false),
                                ).marginOnly(top: 12)
                                // child: Image.asset(AppAssets.orderMangeIphone).marginOnly(top: 12)
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
                                subTitle: '₦${logic.response.data![0].products!.price}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Payment',
                                subTitle: '${logic.response.data![0].paymentMethod??""}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Delivery Charges',
                                subTitle: '${logic.response.data![0].shippingCharges??"0"}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            build_tile(title: 'Discount',
                                subTitle: '-${logic.response.data![0].productDetails!.discount??""}',
                                subTitleColor: AppColors.greenColor),

                            addHeight(12),
                            continueButton(
                                child: build_tile(title: 'Total Amount',
                                    subTitle: '₦ ${logic.response.data![0].totalAmount}',
                                   /* subTitle: '₦ ${logic.productTotal(
                                      discount: logic.response.data![0].productDetails!.discount!,
                                      deliveryCharge: logic.response.data![0].productDetails!.deliveryCharge!,
                                      totalAmount: int.parse('${logic.response.data![0].products!.price??0}')
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
                                subTitle: '${logic.response.data![0].shippingAddress?.fullName?.capitalize??''}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Address',
                                subTitle: '${logic.response.data![0].shippingAddress?.address?.capitalize??''}',
                                subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'Contact No.',
                                subTitle: '${logic.response.data![0].shippingAddress?.mobileNumber??''}',
                                subTitleColor: AppColors.blackColor),

                            // addHeight(12),
                            // build_tile(title: 'Email Id',
                            //     subTitle: 'customer@gmail.com',
                            //     subTitleColor: AppColors.blackColor),

                            addHeight(12),
                            build_tile(title: 'delivery date'.capitalize,
                                subTitle: '${logic.response.data![0].estimatedDelivery??''}',
                                subTitleColor: AppColors.blackColor),


                            addHeight(4),
                          ],
                        )
                    ),
                    addHeight(16),

                    BorderedContainer(
                        radius: 1000,
                        child: AppButton(
                          // buttonColor: AppColors.greyColor,
                            buttonTxtColor: AppColors.blackColor,
                            onButtonTap: () {
                              // Get.to(WalletManagement());

                              if (logic.buttonTxt == 'Ready To Pickup') {
                                showLoader(true);
                                changeOrderStatusApi(orderId: logic.orderId,orderStatus: 'Processing').then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    logic.buttonTxt = 'Mark As Shipped';
                                    logic.update();
                                    Get.find<OrderListController>().selectedTab=1;
                                    Get.find<OrderListController>().update();
                                    Get.find<OrderListController>().fetchOrderList();
                                    print('${logic.buttonTxt}');
                                    Get.back();
                                    showToast('${value.message}');
                                  }
                                });
                                // Get.back();
                              } else if (logic.buttonTxt == 'Mark As Shipped') {
                                showLoader(true);
                                changeOrderStatusApi(orderId: logic.orderId,orderStatus: 'Shipped').then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    logic.buttonTxt = 'Out For Delivery';
                                    logic.update();
                                    Get.find<OrderListController>().selectedTab=2;
                                    Get.find<OrderListController>().update();
                                    Get.find<OrderListController>().fetchOrderList();
                                    print('${logic.buttonTxt}');
                                    Get.back();
                                    showToast('${value.message}');
                                  }
                                });


                              } else if (logic.buttonTxt == 'Out For Delivery') { // remove this
                                showLoader(true);
                                changeOrderStatusApi(orderId: logic.orderId,orderStatus: 'InTransit').then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    logic.buttonTxt = 'In Transit';
                                    logic.update();
                                    Get.find<OrderListController>().selectedTab=2;
                                    Get.find<OrderListController>().update();
                                    Get.find<OrderListController>().fetchOrderList();
                                    print('${logic.buttonTxt}');
                                    Get.back();
                                    showToast('${value.message}');
                                  }
                                });


                              } else if (logic.buttonTxt == 'In Transit') { // and this
                                  showLoader(true);
                                  changeOrderStatusApi(orderId: logic.orderId,orderStatus: 'Delivered').then((value){
                                    showLoader(false);
                                    if(value.status==true){
                                      logic.buttonTxt = 'Delivered';
                                      logic.update();
                                      Get.find<OrderListController>().selectedTab=3;
                                      Get.find<OrderListController>().update();
                                      Get.find<OrderListController>().fetchOrderList();
                                      print('${logic.buttonTxt}');
                                      Get.back();
                                      showToast('${value.message}');
                                    }
                                  });
                              }


                              /*else if (logic.buttonTxt == 'Out For Delivery') { // old working code
                                showLoader(true);
                                changeOrderStatusApi(orderId: logic.orderId,orderStatus: 'Delivered').then((value){
                                  showLoader(false);
                                  if(value.status==true){
                                    logic.buttonTxt = 'Delivered';
                                    logic.update();
                                    Get.find<OrderListController>().selectedTab=3;
                                    Get.find<OrderListController>().update();
                                    Get.find<OrderListController>().fetchOrderList();
                                    print('${logic.buttonTxt}');
                                    Get.back();
                                    showToast('${value.message}');
                                  }
                                });
                              }*/
                            },
                            buttonText: '${logic.buttonTxt}').marginSymmetric(
                            horizontal: 4)
                    ),


                    addHeight(24)


                  ],
                ).marginSymmetric(horizontal: 16),
              ) : Center(child: addText600('No Orders found'));
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
          // color: Colors.red,
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(Get.context!).width*0.6),
            child: addText500('$subTitle', fontFamily: '',
                color: subTitleColor,
                fontSize: 14))
      ],
    );
  }
}
