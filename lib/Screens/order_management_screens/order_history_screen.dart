import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/Api/repos/give_review_repo.dart';
import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/review_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
        titleTxt: "Order History",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: false,
      ),
      body: GetBuilder< OrderListController>(builder: (logic) {
        return Column(
          children: [
            // addHeight(44),
            // backAppBar(onTapBack: () {
            //   Get.back();
            // }, title: 'Order History'),

            addHeight(6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: CustomTextField(
                borderRadius: 30,
                hintText: "Search Product Name",
                fillColor: AppColors.whiteColor,
                suffixIcon: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    AppAssets.searchIcon,
                    color: AppColors.blackColor,
                    width: 31,
                    height: 30,
                  ),
                ),
                onChanged: (val){
                  logic.deBounce.run(() {
                    logic.fetchOrderList(orderId: val);
                  });
                },
              ),
            ),
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
                  }, title: 'To Ship', tab: 0, selectedIndex: logic.selectedTab),
                  addWidth(4),
                  tabButton(onTap: () {
                    logic.selectedTab = 1;
                    setState(() {});
                    logic.fetchOrderList();
                  }, title: 'Shipped', tab: 1, selectedIndex: logic.selectedTab),
                  addWidth(4),
                  tabButton(onTap: () {
                    logic.selectedTab = 2;
                    setState(() {});
                    logic.fetchOrderList();
                  },
                      title: 'Returns/Refunds',
                      tab: 2,
                      selectedIndex: logic.selectedTab),

                  addWidth(4),
                  tabButton(onTap: () {
                    logic.selectedTab = 3;
                    setState(() {});
                    logic.fetchOrderList();
                  },
                      title: 'Delivered',
                      tab: 3,
                      selectedIndex: logic.selectedTab),

                ],
              ).marginSymmetric(horizontal: 16, vertical: 10),
            ),

            Expanded(child:
            logic.isDataLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                : logic.response.data!=null && logic.response.data!.isNotEmpty
                ? SingleChildScrollView(
              child: Column(
                children: [
                  addHeight(14),

                  ...List.generate(

                      logic.response.data?.length??0, (index) {
                    OrderData order = logic.response.data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.orderDetailScreen,arguments: {
                          'order_id': order.orderId,'is_order_history': true});
                      },
                      child: BorderedContainer(

                          child: Column(
                            children: [
                              addHeight(8),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.red
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedImageCircle2(isCircular: false,
                                          imageUrl: order.productImages!.isNotEmpty?'${order.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),
                                      // child: Image.asset(AppAssets.homeScreenIphone2,),
                                      // child: Image.network(
                                      //   AppAssets.demoIphoneImageUrl,
                                      //   // "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                                      //   // width: 50, height: 50,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  addWidth(10),
                                  Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 260),
                                      child: addText600('${order.productName?.capitalize??''}',
                                          fontFamily: 'Manrope',
                                          color: AppColors.textColor2,
                                          fontSize: 14)),
                                  addWidth(4),
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: order.shippingIndicator=="F"?AppColors.primaryColor
                                          : order.shippingIndicator=="S"?AppColors.redColor: AppColors.blueColor2
                                    ),
                                    child: Center(child: addText500('${order.shippingIndicator}',fontSize: 10,
                                        textAlign: TextAlign.center,height: 1.0,color: AppColors.whiteColor)),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios, size: 14,)
                                ],
                              ),

                              addHeight(6),
                              // Container(
                              //     alignment: Alignment.centerLeft,
                              //     // constraints: BoxConstraints(maxWidth: 260),
                              //     child: addText500(
                              //         'Order Id :${order.orderId}', fontFamily: 'Manrope',
                              //         color: AppColors.blackColor,
                              //         fontSize: 12)),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  // constraints: BoxConstraints(maxWidth: 260),
                                  child: makeTextSelectable(
                                      'Order Id :${order.orderId}',fontSize: 12,fontFamily: 'Manrope', color: AppColors.blackColor,
                                      style: TextStyle(
                                         fontWeight: FontWeight.w500,
                                       ))),

                              addHeight(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  order.returnRequest!=null && (order.returnRequest?.status?.toLowerCase()=='declined')
                                      ? continueButton(title: 'Return ${order.returnRequest?.status??''}',btnTxtcolor: Colors.white,color: Colors.red)
                                      : logic.selectedTab==2?continueButton(title: 'Return ${order.returnRequest?.status??''}')
                                      : continueButton(title: '${order.orderStatus}'),
                                  addWidth(10),
                                  // if(index == 0 )
                                    GestureDetector(
                                      onTap: () {
                                        ReviewDialog.show(context,onTap: () {

                                          showLoader(true);
                                          giveRatingApi(productId: order.orderId,userDescription: logic.ratingCtrl.text,userRating: logic.initialRating).then((value){
                                            showLoader(false);
                                            if(value.status==true){
                                              Get.back();
                                              showToast('${value.message}');
                                            }
                                          });
                                        },reviewCtrl: logic.ratingCtrl,
                                            initialRating: logic.initialRating);
                                      },
                                      child: Text("Review",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: 'Manrope',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,
                                          )
                                      ),
                                    ),
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
                              if(logic.selectedTab == 2 && order.returnRequest!=null)
                                Column(
                                  children: [

                                    if(order.returnRequest?.status?.toLowerCase()=='declined')
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: addText400('Return request has been denied by the seller "${order.returnRequest?.declineReason}". Need more help? Please contact the support',fontSize: 13)),

                                    if(order.returnRequest?.status?.toLowerCase()=='accepted')
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: addText400('Return request accepted. The process for the return will be initiated soon.',fontSize: 13)),

                                    if(order.returnRequest?.status?.toLowerCase()=='pending')
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: addText400('Return request has been initiated, we will inform you soon.',fontSize: 13)),

                                  ],
                                ),
                              addHeight(8),
                            ],
                          )).marginOnly(bottom: 10),
                    );
                  }),
                  addHeight(70),
                ],
              ).marginSymmetric(horizontal: 16),
            )
            : Center(child: addText600('No Orders found'))
            )


          ],
        );
      }),
    );
  }

  continueButton({void Function()? onTap, String? title,Color? color,Color? btnTxtcolor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        constraints: const BoxConstraints(maxHeight: 28),
        decoration: BoxDecoration(
            color: color??AppColors.buttonColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: addText600('$title',
            fontFamily: 'Manrope', fontSize: 12, color: btnTxtcolor??AppColors.blackColor)),
      ),
    );
  }

  tabButton(
      {void Function()? onTap, String? title, int tab = 1, int?selectedIndex }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 80,
        constraints: const BoxConstraints(maxHeight: 36),
        decoration: BoxDecoration(
            color: tab == selectedIndex ? AppColors.primaryColor : null,
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
