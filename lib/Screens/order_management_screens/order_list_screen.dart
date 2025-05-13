
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/Api/repos/accept_decline_product_return_repo.dart';
import 'package:flipzy/Api/repos/send_refund_repo.dart';
import 'package:flipzy/Screens/order_management_screens/order_confirm_screen.dart';
import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/decline_order_success_dialogue.dart';
import 'package:flipzy/dialogues/decline_return_request_dialogue.dart';
import 'package:flipzy/dialogues/refund_order_confirmation_dialogue.dart';
import 'package:flipzy/dialogues/refund_order_not_confirm_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_detail_refunds_screen.dart';
import 'order_detail_screen.dart';
import 'order_mark_ship_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: AppColors.appBgColor,
      // drawerEnableOpenDragGesture: false,
      // drawer: CustomDrawer(),
      appBar: customAppBar(
        backgroundColor: AppColors.bgColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: IconButton(
            onPressed: (){
              Get.back();},
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "Order Management",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),
      body: GetBuilder<OrderListController>(builder: (logic) {
        return SafeArea(
          child: Column(
            children: [
              // addHeight(20),
              // backAppBar(onTapBack: () {
              //   print('tap');
              //   Get.back();
              //   // scaffoldKey.currentState?.openDrawer();
              // }),

              addHeight(8),
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: CustomTextField(
                  controller: logic.searchCtrl,
                  fillColor: AppColors.whiteColor,
                  hintText: 'Enter Order Id',
                  suffixIcon: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(Icons.search, color: Colors.black,),
                  ).marginOnly(right: 10),
                  onChanged: (val){
                    logic.deBounce.run(() {
                      logic.fetchOrderList(orderId: val);
                    });
                  },

                ),
              ).marginSymmetric(horizontal: 20),


              // Row(
              //   children: [
              //
              //
              //   ],
              // ).marginSymmetric(horizontal:16,vertical: 10),

              SizedBox(
                // color: Colors.red,
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    tabButton(onTap: () {
                      logic.selectedTab = 0;
                      setState(() {});
                      logic.fetchOrderList();
                    }, title: 'Inbox', tab: 0, selectedIndex: logic.selectedTab),
                    addWidth(12),
                    tabButton(onTap: () {
                      logic.selectedTab = 1;
                      setState(() {});
                      logic.fetchOrderList();
                    }, title: 'To Ship', tab: 1, selectedIndex: logic.selectedTab),
                    addWidth(12),
                    tabButton(onTap: () {
                      logic.selectedTab = 2;
                      setState(() {});logic.fetchOrderList();
                    }, title: 'Shipped', tab: 2, selectedIndex: logic.selectedTab),
                    addWidth(12),
                    tabButton(onTap: () {
                      logic.selectedTab = 3;
                      setState(() {});logic.fetchOrderList();
                    }, title: 'Delivered', tab: 3, selectedIndex: logic.selectedTab),
                    addWidth(12),
                    tabButton(onTap: () {
                      logic.selectedTab = 4;
                      setState(() {});logic.fetchOrderList();
                    },
                        title: 'Return/Refunds',
                        tab: 4,
                        selectedIndex: logic.selectedTab),
                  ],
                ).marginOnly(left: 16, top: 10, bottom: 10),
              ),


              Expanded(child: 
              logic.isDataLoading
                  ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                  : logic.response.data!=null && logic.response.data!.isNotEmpty
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    addHeight(14),

                    ...List.generate(logic.response.data?.length??0, (index) {

                      OrderData order = logic.response.data![index];


                      return GestureDetector(
                        onTap: () {
                          if (logic.selectedTab == 4) {
                            Get.toNamed(AppRoutes.orderDetailRefundsScreen,
                                arguments: {'order_id':order.orderId});
                          } else if(logic.selectedTab == 0 && order.orderStatus==''){
                            Get.toNamed(AppRoutes.orderConfirmScreen,
                                arguments: {'order_id':order.orderId});
                          }
                          else {
                            // Get.toNamed(AppRoutes.orderDetailScreen,arguments: {'order_id': order.orderId});
                            Get.toNamed(AppRoutes.orderMarkShipScreen,
                                arguments: {'order_id':order.orderId, 'button_step': logic.selectedTab});
                          }
                        },
                        child: BorderedContainer(

                            child: Column(
                              children: [
                                addHeight(8),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        // child: Image.network(
                                        //   AppAssets.demoIphoneImageUrl,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        child: CachedImageCircle2(isCircular: false,
                                            imageUrl: order.productImages!.isNotEmpty?'${order.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),
                                      ),
                                    ),
                                    addWidth(10),
                                    Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 246),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            addText500('${order.productName?.capitalize??''}',
                                                fontFamily: 'Manrope',
                                                color: AppColors.textColor2,
                                                fontSize: 14),
                                            addWidth(4),
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: order.shippingIndicator=="F"?AppColors.primaryColor
                                                      : order.shippingIndicator=="S"?AppColors.redColor: AppColors.blueColor2
                                              ),
                                              child: Center(
                                                child: addText500('${order.shippingIndicator}',fontSize: 10,
                                                    textAlign: TextAlign.center,height: 1.0,color: AppColors.whiteColor),
                                              ),
                                            )
                                          ],
                                        )),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios, size: 14,)
                                  ],
                                ),

                                addHeight(12),
                                /*Container(
                                  alignment: Alignment.centerLeft,
                                  constraints: BoxConstraints(
                                      maxWidth: 260),
                                  child: Text(
                                    'Order Id :${order.orderId}',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      // decoration: TextDecoration.underline,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.blackColor,
                                    ),
                                    // style: TextStyle(
                                    //   fontSize: 16,
                                    //   decoration: TextDecoration.underline,
                                    //   decorationColor: Colors.blue, // optional, changes the underline color
                                    //   decorationThickness: 2,       // optional, changes the underline thickness
                                    // ),
                                  ),
                                  // child: addText600('Review', fontFamily: 'Manrope',color: AppColors.blackColor)
                                ),*/
                                Container(
                                  alignment: Alignment.centerLeft,
                                  constraints: BoxConstraints(
                                      maxWidth: 260),
                                  child: makeTextSelectable(
                                      'Order Id :${order.orderId}',fontSize: 12,fontFamily: 'Manrope', color: AppColors.blackColor,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      )),
                                  // child: addText600('Review', fontFamily: 'Manrope',color: AppColors.blackColor)
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  constraints: BoxConstraints(
                                      maxWidth: 260),
                                  child: makeTextSelectable(
                                      'Payment Status :${order.paymentStatus}',fontSize: 12,fontFamily: 'Manrope', color: AppColors.blackColor,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      )),
                                  // child: addText600('Review', fontFamily: 'Manrope',color: AppColors.blackColor)
                                ),
                                addHeight(12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [


                                    order.returnRequest!=null && (order.returnRequest?.status?.toLowerCase()=='declined')
                                        ? continueButton(paymentStatus: 'Return ${order.returnRequest?.status??'edf'}',btnTxtcolor: Colors.white,color: Colors.red)
                                        : logic.selectedTab==4?continueButton(paymentStatus: 'Return ${order.returnRequest?.status??'df'}')
                                        : order.orderStatus!.isNotEmpty?continueButton(paymentStatus: '${order.orderStatus}'):SizedBox.shrink(),
                                        // : continueButton(paymentStatus: '${order.orderStatus}'),
                                    addWidth(10),

                                    Spacer(),
                                    Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 260),
                                        child: addText700(
                                            '₦${order.totalAmount}', fontFamily: '',
                                            color: AppColors.blackColor,
                                            fontSize: 16)),
                                  ],
                                ),
                                addHeight(8),

                                if(logic.selectedTab == 4 && order.returnRequest!=null)
                                Column(
                                  children: [
                                    if(order.returnRequest?.status?.toLowerCase()=='pending')
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        continueButton(
                                            paymentStatus: 'Accept',
                                            onTap: (){
                                              showLoader(true);
                                              acceptDeclineProductReturnApi(
                                                  orderId: order.orderId,
                                                  action: 'accept',
                                                  declineReason: logic.declineMessage.text).then((value){
                                                showLoader(false);
                                                if(value.status==true){
                                                  Future.microtask((){
                                                    Get.back();
                                                    // DeclineOrderSuccessDialog.show(Get.context!);
                                                  });
                                                }
                                              });
                                            },
                                            color: Colors.green,btnTxtcolor: Colors.white),
                                        addWidth(10),
                                        continueButton(paymentStatus: 'Decline',
                                            onTap: (){

                                              DeclineReturnRequestDialog.show(context,
                                                  msgCtrl: logic.declineMessage,
                                                  onTap: (){
                                                    showLoader(true);
                                                    acceptDeclineProductReturnApi(
                                                        orderId: order.orderId,
                                                        action: 'decline',
                                                        declineReason: logic.declineMessage.text).then((value){
                                                      showLoader(false);
                                                      if(value.status==true){
                                                        Future.microtask((){
                                                          Get.back();
                                                          DeclineOrderSuccessDialog.show(Get.context!);
                                                        });
                                                      }
                                                    });});
                                            },
                                            color: Colors.red,btnTxtcolor: Colors.white),

                                      ],
                                    ),
                                    
                                    if(order.returnRequest?.status?.toLowerCase()=='declined')
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: addText400('Declined Reason: ${order.returnRequest?.declineReason}',fontSize: 13)).marginSymmetric(horizontal: 14),


                                    if(order.returnRequest?.status?.toLowerCase()=='accepted')
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          continueButton(
                                              paymentStatus: 'Recieved',
                                              onTap: (){
                                                showLoader(true);
                                                sendRefundApi(
                                                    orderId: order.orderId,
                                                    isProductRecived: true).then((value){
                                                  showLoader(false);
                                                  if(value.status==true){
                                                    Future.microtask((){
                                                      Get.back();
                                                      // DeclineOrderSuccessDialog.show(Get.context!);
                                                      RefundOrderConfirmationDialog.show(Get.context!);
                                                    });
                                                  }
                                                });
                                              },
                                              color: Colors.green,btnTxtcolor: Colors.white),
                                          addWidth(10),
                                          continueButton(paymentStatus: 'Not Received Yet',
                                              onTap: (){

                                                showLoader(true);
                                                sendRefundApi(
                                                    orderId: order.orderId,
                                                    isProductRecived: false).then((value){
                                                  showLoader(false);
                                                  if(value.status==true){
                                                    print('object::::${value.message} && ${value.status}');
                                                    Future.microtask((){
                                                      Get.back();
                                                      RefundOrderNotConfirmationDialog.show(context);
                                                    });
                                                  }
                                                });
                                              },
                                              color: Colors.red,btnTxtcolor: Colors.white),

                                        ],
                                      ),

                                  ],
                                ),
                                addHeight(8),
                              ],
                            )).marginOnly(bottom: 10),
                      );
                    })

                  ],
                ).marginSymmetric(horizontal: 16),
              )
                  : Center(child: addText600('No Orders found'))
              )


            ],
          ),
        );
      }),
    );
  }

  continueButton({String? paymentStatus,void Function()? onTap,Color? color,Color? btnTxtcolor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        constraints: const BoxConstraints(maxHeight: 32),
        decoration: BoxDecoration(
            color: color??AppColors.buttonColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText500('${paymentStatus}',
            fontFamily: 'Manrope', fontSize: 12, color: btnTxtcolor??AppColors.blackColor)),
      ),
    );
  }

  tabButton(
      {void Function()? onTap, String? title, int tab = 0, int?selectedIndex }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 80,
        constraints: const BoxConstraints(maxHeight: 36),
        decoration: BoxDecoration(
            color: tab == selectedIndex ? AppColors.primaryColor : AppColors
                .whiteColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText700('$title',
            fontFamily: 'Manrope',
            fontSize: 13,
            color: tab == selectedIndex ? AppColors.blackColor : AppColors
                .blackColor)).marginSymmetric(horizontal: 14),
      ),
    );
  }
}
