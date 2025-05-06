
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/chat_with_users_model.dart';
import 'package:flipzy/Screens/makeOfferChat.dart';
import 'package:flipzy/Screens/seller_profile.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/controllers/product-detail_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: GetBuilder<ProductDetailController>(
          init: ProductDetailController(),
          builder: (logic) {
        return Column(
          children: [
            addHeight(44),
            backAppBar(
                title: "${logic.productName?.capitalize??''}",
                onTapBack: () {
                  Get.back();
                }),

            Expanded(child:
                logic.isDataLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor,))
                    : logic.response.data!=null?SingleChildScrollView(
              child: Column(
                children: [
                  addHeight(14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      if(logic.productImages!=null && logic.productImages!.length>1)
                      IconButton(
                        onPressed: logic.goToPreviousImage,
                        icon: Icon(Icons.keyboard_arrow_left, size: 32),
                      ),
                      // Main image container
                      Container(
                        width: 200, // Adjust as needed
                        height: 200, // Adjust as needed
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        // child: Image.asset(AppAssets.bigIphoneProductDetail),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedImageCircle2(isCircular: false,
                              imageUrl: logic.productImages!.isNotEmpty?'${logic.productImages![logic.currentIndex]}':ApiUrls.productEmptyImgUrl),
                        ),

                      ),

                      if(logic.productImages!=null && logic.productImages!.length>1)
                      IconButton(
                        onPressed: logic.goToNextImage,
                        icon: Icon(Icons.keyboard_arrow_right, size: 32),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  if(logic.productImages!=null && logic.productImages!.length>1)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: logic.productImages!
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        String imageUrl = entry.value;
                        return SizedBox(
                            height: 60, width: 60,
                            child: CachedImageCircle2(isCircular: false,imageUrl: '$imageUrl').marginOnly(right: 10)
                        );
                        // return GestureDetector(
                        //   onTap: () => _onThumbnailTap(index),
                        //   child: Container(
                        //     width: 50,
                        //     height: 80,
                        //     margin: EdgeInsets.symmetric(horizontal: 4),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       // shape: BoxShape.circle,
                        //       border: Border.all(
                        //         color: _currentIndex == index ? Colors.blue : Colors.grey,
                        //         width: 2,
                        //       ),
                        //       // image: DecorationImage(
                        //       //   // image: Image.asset(name),
                        //       //   image: NetworkImage(imageUrl),
                        //       //   fit: BoxFit.cover,
                        //       // ),
                        //     ),
                        //     child: Image.asset(imageUrl),
                        //   ),
                        // );
                      }).toList(),),),

                  if(logic.productImages!=null && logic.productImages!.length>1)
                  addHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addText700('₦${logic.response.data?.productList?.price??0}', fontFamily: '',
                          color: AppColors.blackColor,
                          fontSize: 24),
                      // SvgPicture.asset(AppAssets.cartIC),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText700('${logic.response.data?.productList?.productName?.capitalize??''}',
                          fontFamily: 'Manrope',
                          color: AppColors.textColor3,
                          fontSize: 18)),
                  if(logic.response.data!.productList?.stock == 'In Stock')
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            logic.updateCounter(
                                true, logic.response.data!.productList!.stockQuantity!);
                            logic.update();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.containerBorderColor,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.add, size: 18,).marginAll(4)),
                        ),
                        // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                        addText500('${logic.counter}', fontSize: 14,
                            fontFamily: 'Manrope',
                            color: AppColors.blackColor).marginSymmetric(horizontal: 8),
                        GestureDetector(
                          onTap: () {
                            logic.updateCounter(
                                false, logic.response.data!.productList!.stockQuantity!);
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
                    ).marginOnly(top: 12),
                  ),
                  addHeight(20),

                  BorderedContainer(
                      padding: 20,
                      isBorder: false,
                      bGColor: AppColors.greenColor.withOpacity(0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // addHeight(10),
                          addText700('Details', fontFamily: 'Manrope',
                              color: AppColors.blackColor,
                              fontSize: 16),
                          addHeight(12),
                          build_tile(
                              title: 'Brand',
                              subTitle: '${logic.response.data?.productList?.brandName?.capitalize??''}',
                              subTitleColor: AppColors.blackColor),


                          addHeight(12),
                          build_tile(title: 'Category',subTitle: '${logic.response.data?.productList?.category?.capitalize??''}',subTitleColor: AppColors.blackColor),
  addHeight(12),
                          build_tile(title: 'Stock',
                              subTitle: '${logic.response.data?.productList?.stock?.capitalize??''}',subTitleColor: AppColors.blackColor),

                          addHeight(12),
                          

                        ],
                      )
                  ),
                  addHeight(16),
                  Container(
                    width: double.infinity,
                    child: BorderedContainer(
                        padding: 20,
                        isBorder: false,
                        bGColor: AppColors.greenColor.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addText700('Description', fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 16),
                            addHeight(12),

                            addText500(
                                '${logic.response.data?.productList?.productDescription?.capitalizeFirst??''}',
                                fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 14),

                            addHeight(4),
                          ],
                        )
                    ),
                  ),
                  addHeight(10),

                  GestureDetector(
                    onTap: () {
                      Get.to(SellerProfileScreen(sellerId: logic.response.data?.productList?.sellerId??'',
                        sellerName: logic.response.data?.sellerName??'',));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [

                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.12,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedImageCircle2(isCircular: true,imageUrl: '${logic.response.data?.sellerImage}',height: 38,width: 38),
                              // child: Image.asset(AppAssets.notificationProfileIC),
                              // child: Image.network(
                              //   "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                              //   // width: 50, height: 50,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          SizedBox(width: 10,),

                          addText700('${logic.response.data?.sellerName?.capitalize??''}', fontFamily: 'Manrope',
                              color: AppColors.blackColor,
                              fontSize: 14),

                          Spacer(),


                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.blackColor),
                            ),
                            child: Row(
                              children: [
                                if(logic.response.data?.sellerRating.toString() !='NaN')
                                SvgPicture.asset(
                                  AppAssets.starImage,
                                  fit: BoxFit
                                      .contain, // Try 'contain' or 'fitWidth' if needed
                                ),
                                addText400(logic.response.data?.sellerRating.toString()=='NaN'?' Not Rated Yet': '${logic.response.data?.sellerRating}', fontFamily: 'Manrope',
                                    color: AppColors.blackColor,
                                    fontSize: 12),
                              ],
                            ),
                          ),

                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  ),

                  // addHeight(10),
                  //
                  // addText500('10 people have purchase this product in past',
                  //     fontFamily: 'Manrope',
                  //     color: AppColors.blackColor,
                  //     fontSize: 14),

                  addHeight(10),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      // color: AppColors.greenColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.greyColor)
                    ),
                    child: Row(
                      children: [

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                  MakeOfferChatScreen(
                                    price: logic.response.data?.productList?.price,
                                receiverData: ChatWithUser(
                                  rowid: '',
                                  isRead: false,
                                  session: true,
                                  userId: logic.response.data?.productList?.sellerId,
                                  firstname: logic.response.data?.sellerName,
                                  profileImage: logic.response.data?.sellerImage,
                                  lastMessage: '',
                                  createdAt: DateTime.now()),));
                            },
                            child: Container(

                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.greenColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: AppColors.greyColor)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.makeOfferIC,
                                    fit: BoxFit
                                        .contain, // Try 'contain' or 'fitWidth' if needed
                                  ),
                                  SizedBox(width: 10,),
                                  addText700(
                                      'Make Offer', fontFamily: 'Manrope',
                                      color: AppColors.blackColor,
                                      fontSize: 14),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {

                              Get.toNamed(AppRoutes.chattingScreen,arguments: {
                                'socket_instance':Get.find<ChatController>().socketService,
                                'receiver_data':ChatWithUser(
                                    rowid: '',
                                    isRead: false,
                                    session: true,
                                    userId: logic.response.data?.productList?.sellerId,
                                    firstname: logic.response.data?.sellerName,
                                    profileImage: logic.response.data?.sellerImage,
                                    lastMessage: '',
                                    createdAt: DateTime.now())});

                              /*showLoader(true);
                              addFriendApi(receiver_id: logic.response.data?.productList?.sellerId).then((value){
                                showLoader(false);
                                if(value.status==true){
                                  Get.find<ChatController>().socketService.connect();
                                  Get.find<ChatController>().letsConnect('${AuthData().userModel?.id}');
                                  Get.toNamed(AppRoutes.chattingScreen,arguments: {
                                    'socket_instance':Get.find<ChatController>().socketService,
                                    'receiver_data':ChatUsersResponse(
                                        userId: logic.response.data?.productList?.sellerId,
                                        firstname: logic.response.data?.sellerName,
                                        lastMessage: '',
                                        profileImage: logic.response.data?.sellerImage,
                                        createdAt: DateTime.now())});
                                } else{
                                  Get.toNamed(AppRoutes.chattingScreen,arguments: {
                                    'socket_instance':Get.find<ChatController>().socketService,
                                    'receiver_data':ChatUsersResponse(
                                        userId: logic.response.data?.productList?.sellerId,
                                        firstname: logic.response.data?.sellerName,
                                        lastMessage: '',
                                        profileImage: logic.response.data?.sellerImage,
                                        createdAt: DateTime.now())});
                                };

                              });

*/

                            },
                            child: Container(

                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: AppColors.greyColor)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.chatIC,
                                    fit: BoxFit
                                        .contain, // Try 'contain' or 'fitWidth' if needed
                                  ),
                                  SizedBox(width: 10,),
                                  addText700('Chat', fontFamily: 'Manrope',
                                      color: AppColors.blackColor,
                                      fontSize: 14),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  addHeight(16),

                  AppButton(
                    onButtonTap: () {
                      // makePayment(context);
/*// web view
                      showLoader(true);
                      getPayUrlApi(productId: logic.productId).then((value){
                        showLoader(false);
                        if(value.status==true){
                          Get.toNamed(AppRoutes.paymentWebView, arguments: {
                            'initial_url':value.data?.link??'',
                            'product_id':logic.productId})?.then((value){

                              log('call back result ${value}');
                              if(value!=null){
                                showLoader(true);
                                verifyPaymentApi(isBoost: false,productId: logic.productId,tx_ref: value['tx_ref']).then((val){
                                  showLoader(false);
                                  if(val.success==true){
                                    showToast('${val.message}');
                                    Get.back();
                                  }
                                });
                              };
                          });
                        }else {
                          showToastError('${value.message}');
                        }

                      });*/




                      // buy now Old api
                      /*buyNowApi(
                          productId: logic.productId,
                          price: logic.response.data!.productList!.price,
                          paymentMethod: 'COD',
                          paymentStatus: 'Pending',
                          address: '${AuthData().userModel?.location}').then((value){showLoader(false);
                            if(value.status==true){ showToast('${value.message}');
                            }});*/


                      Get.toNamed(AppRoutes.checkOutScreen,
                          arguments: {
                        'quantity':logic.counter,
                        'product_detail':logic.response.data?.productList})?.then((val){
                          if(val!=null){
                            logic.counter=val;
                            logic.update();
                          }
                      });

                      },
                    buttonText: 'Buy Now',
                    buttonTxtColor: AppColors.blackColor),

                  addHeight(24)
                ],
              ).marginSymmetric(horizontal: 16),
            ) : Center(child: addText600('No detail found')))


          ],
        );
      }),
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
      .greenColor }) { return Row(
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
    );}

  /*void makePayment(BuildContext context) async {
    final Customer customer = Customer(
      name: "John Doe",
      phoneNumber: "08100000000",
      email: "johndoe@example.com",
    );

    final Flutterwave flutterwave = Flutterwave(
      publicKey: "FLWPUBK_TEST-3d703fce0da616751338b38e88a9286a-X",
      currency: "NGN",
      redirectUrl: "https://your-redirect-url.com",
      txRef: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: "1000",
      customer: customer,
      paymentOptions: "card, banktransfer, ussd",
      customization: Customization(title: "Flipzy Payment"),
      isTestMode: true,
    );

    final ChargeResponse response = await flutterwave.charge(context);

    print("✅ Payment successful 1 : ${jsonEncode(response)}");
    if (response.status=='successful') {
    // if (response.success ?? false) {
      print("✅ Payment successful: ${response.transactionId}");
    } else {
      print("❌ Payment failed or cancelled");
    }
  }*/


}
