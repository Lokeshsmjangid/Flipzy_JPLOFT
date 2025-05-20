
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/chat_with_users_model.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/Api/repos/bubble_ship_repo.dart';
import 'package:flipzy/Api/repos/report_product_repo.dart';
import 'package:flipzy/Screens/chats/enlarge_image.dart';
import 'package:flipzy/Screens/makeOfferChat.dart';
import 'package:flipzy/Screens/seller_profile.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/controllers/product-detail_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/report_chat_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  final ss= Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
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
        titleTxt: "${ss.productName?.capitalize??''}",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
        actionItems: [
          PopupMenuButton<String>(
            offset: Offset(0, 54),
            icon: SvgPicture.asset(
              AppAssets.threeDotsIc,
              color: AppColors.blackColor,
              height: 24,
              width: 24,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onSelected: (value) {
              if (value == 'Report') {
                ReportChatDialogue.show(context,msgCtrl: ss.repportCtrl,isChat:false,onTap: (){
                  if(ss.repportCtrl.text.isEmpty){
                    showToastError('Please enter your reason,why are you reporting this product');
                  } else{

                    showLoader(true);
                    reportProductApi(productId: ss.productId,reason: ss.repportCtrl.text).then((onval){
                      showLoader(false);
                      if(onval.status==true){
                        ss.repportCtrl.clear();
                        showToast('${onval.message}');
                        Get.back();

                      }else if(onval.status==false){
                        showToastError('${onval.message}');
                      }
                    });

                  }
                });

                // handle report
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Report',
                  child: addText400(
                      'Report', fontSize: 14, color: AppColors.blackColor)),

            ],
          )
        ]
      ),
      body: GetBuilder<ProductDetailController>(
          init: ProductDetailController(),
          builder: (logic) {
        return Column(
          children: [
            addHeight(20),

            Expanded(child:
            logic.isDataLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor,))
                    : logic.response.data!=null
                    ? SingleChildScrollView(
              child: Column(
                children: [

                  BorderedContainer(
                    bGColor: AppColors.bgColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: CarouselSlider(
                            carouselController: logic.carouselSliderController,
                              items: List.generate(
                                  growable: true,
                                  logic.productImages !=null && logic.productImages!.isNotEmpty
                                      ? logic.productImages!.length
                                      : 1, (index){
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: GestureDetector(
                                    onTap: (){

                                      if(logic.productImages!=null && logic.productImages!.isNotEmpty)
                                      Get.to(()=>EnlargeImage(url: logic.productImages![index]));
                                    },
                                    child: CachedImageCircle2(isCircular: false,
                                        imageUrl: logic.productImages!.isNotEmpty?'${logic.productImages![index]}':ApiUrls.productEmptyImgUrl),
                                  ),
                                );

                              }),
                              options: CarouselOptions(
                                height: 400,
                                // aspectRatio: 12/8,
                                viewportFraction: 0.4,
                                // viewportFraction: 0.9,
                                initialPage: logic.currentIndex,
                                reverse: false,
                                animateToClosest: true,
                                autoPlay: logic.productImages !=null && logic.productImages!.isNotEmpty?true:false,
                                // disableCenter: false,
                                enableInfiniteScroll: logic.productImages !=null && logic.productImages!.isNotEmpty?true:false,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(milliseconds: 2500),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                onPageChanged: (val,ot){
                                  logic.currentIndex = val;
                                  logic.update();
                                  // flipzyPrint(message: 'Current index: ${logic.currentIndex}' );
                                },
                                scrollDirection: Axis.horizontal,
                              )
                          ),
                        ),

                        // indicator
                        if(logic.productImages!=null && logic.productImages!.length>1)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: logic.productImages!.asMap().entries.map((entry) {
                              int index = entry.key;
                              String imageUrl = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  flipzyPrint(message: 'animateToPage: ${index}');

                                  if (logic.carouselSliderController != null) {
                                    logic.carouselSliderController.animateToPage(index);
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 2,vertical: 8),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: logic.currentIndex==index?AppColors.primaryColor:AppColors.containerBorderColor2,width: 1.5),
                                        borderRadius: BorderRadius.circular(30),color: AppColors.bgColor),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000000),
                                      child: CachedImageCircle2(
                                          isCircular: false,
                                          imageUrl: '$imageUrl',
                                          fit: BoxFit.cover,
                                          height: 36, width: 60),
                                    )
                                ),
                               /* child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                          .withOpacity(logic.currentIndex == entry.key ? 0.9 : 0.4)),
                                ),*/
                              );
                            }).toList(),
                          ),
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [




                            // old image code
                           /* if(logic.productImages!=null && logic.productImages!.length>1)
                              IconButton(
                                onPressed: logic.goToPreviousImage,
                                icon: Icon(Icons.keyboard_arrow_left, size: 32),
                              ),
                            // Main image container
                            GestureDetector(
                              onTap: (){
                                if(logic.productImages!.isNotEmpty)
                                Get.to(()=>EnlargeImage(url: logic.productImages![logic.currentIndex]));
                              },
                              child: Container(
                                width: 190, // Adjust as needed
                                height: 190, // Adjust as needed
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                // child: Image.asset(AppAssets.bigIphoneProductDetail),

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedImageCircle2(isCircular: false,
                                      imageUrl: logic.productImages!.isNotEmpty?'${logic.productImages![logic.currentIndex]}':ApiUrls.productEmptyImgUrl),
                                ),

                              ),
                            ),

                            if(logic.productImages!=null && logic.productImages!.length>1)
                              IconButton(
                                onPressed: logic.goToNextImage,
                                icon: Icon(Icons.keyboard_arrow_right, size: 32),
                              ),*/
                          ],
                        ),
                        if(logic.productImages!=null && logic.productImages!.length>1)
                        SizedBox(height: 10,),

                        /*if(logic.productImages!=null && logic.productImages!.length>1)
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
                                return GestureDetector(
                                  onTap: (){

                                    Get.to(()=>EnlargeImage(url: logic.productImages![index]));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: logic.currentIndex==index?AppColors.primaryColor:AppColors.containerBorderColor2,width: 1.5),
                                          borderRadius: BorderRadius.circular(30),color: AppColors.bgColor),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(1000000),
                                        child: CachedImageCircle2(
                                            isCircular: false,
                                            imageUrl: '$imageUrl',
                                            fit: BoxFit.cover,
                                            height: 36, width: 60),
                                      )
                                  ).marginOnly(right: 4),
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
                              }).toList(),),),*/
                      ],
                    )
                  ),

                  addHeight(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addText700('₦${logic.response.data?.productList?.price??0}', fontFamily: '',
                          color: AppColors.blackColor,
                          fontSize: 24),
                      GestureDetector(
                        onTap: () {
                          logic.response.data?.productList!.favoriteIcon = !logic.response.data!.productList!.favoriteIcon!;
                          logic.update();
                          flipzyPrint(
                              message: 'message: ${logic.response.data?.productList!.favoriteIcon}');

                          addToFavApi(
                              productId: logic.response.data?.productList!.id)
                              .then((value) {
                            if (value.status == true) {
                              showToast('${value.message}');
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appGreenColor,
                            shape: BoxShape.circle ,
                          ),
                          // margin: EdgeInsets.only(right: 5),
                          child: SvgPicture.asset(
                            AppAssets.isFavouriteSelect,
                            // AppAssets.editPenIc,
                            color: logic.response.data?.productList!.favoriteIcon==true?null:AppColors.containerBorderColor1,
                            fit: BoxFit.contain,
                            height: 15, width: 15,
                          ).marginAll(6),
                        ),
                      ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addText500('Qty:').marginOnly(top: 12),
                        Row(

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
                                logic.updateCounter( false, logic.response.data!.productList!.stockQuantity!);
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
                        ),
                      ],
                    ),
                  ),
                  addHeight(20),

                  BorderedContainer(
                      padding: 20,
                      isBorder: true,
                      bGColor: AppColors.whiteColor,
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
                          build_tile(title: 'Stock', subTitle: '${logic.response.data?.productList?.stock?.capitalize??''}',subTitleColor: AppColors.blackColor),

                          if(logic.response.data!.productList!.shippingCharges!.isNotEmpty)
                            addHeight(12),
                          if(logic.response.data!.productList!.shippingCharges!.isNotEmpty)
                            build_tile(
                                title: 'Available In Cities:',
                                subTitle: '${logic.response.data!.productList!.shippingCharges!
                                    .map((city) => city.city?.capitalize ?? '')
                                    .toList()
                                    .join(', ')}',subTitleColor: AppColors.blackColor),

                          addHeight(12),


                        ],
                      )
                  ),
                  addHeight(16),
                  Container(
                    width: double.infinity,
                    child: BorderedContainer(
                        padding: 20,
                        isBorder: true,
                        bGColor: AppColors.whiteColor,
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



                  GestureDetector(
                    onTap: () {

                      String? productIdToReopen = logic.productId;
                      String? productNameToReopen = logic.productName;
                      Get.back();
                      Get.to(() =>
                          SellerProfileScreen(sellerId: logic.response.data?.productList?.sellerId??'',
                        sellerName: logic.response.data?.sellerName??''))?.then((onBack){
                        Get.toNamed(AppRoutes.productDetailScreen,
                            arguments: {'product_id':productIdToReopen,'product_name':productNameToReopen});
                      });

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
                            width: MediaQuery.of(context).size.width * 0.12,
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
                  ).marginOnly(top: 10),

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
                              Get.to(() =>
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



                  logic.response.data!.productList?.stock == 'In Stock'? AppButton(
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


                      if(logic.response.data?.productList?.sellBeyondCityLimits?.toLowerCase()=='yes'){
                        showLoader(true);
                        bubbleShipApi(productId: logic.productId).then((onValue){
                          showLoader(false);
                          if(onValue.status==true){
                            Get.toNamed(AppRoutes.checkOutScreen, arguments: {
                              'quantity':logic.counter,
                              'product_detail':logic.response.data?.productList})?.then((val){
                              if(val!=null){
                                logic.counter=val;
                                logic.update();
                              }
                            });
                          } else if(onValue.status==false){
                            showToastError('${onValue.message}');
                          }
                        });
                      }
                      else {
                        Get.toNamed(AppRoutes.checkOutScreen, arguments: {
                          'quantity':logic.counter,
                          'product_detail':logic.response.data?.productList})?.then((val){
                          if(val!=null){
                            logic.counter=val;
                            logic.update();
                          }
                        });
                      };

                      },
                    buttonText: 'Buy Now',
                    buttonTxtColor: AppColors.blackColor):AppButton(
                    onButtonTap: (){},
                    buttonText: 'Out Of Stock',
                      buttonColor: AppColors.containerBorderColor1,
                    buttonTxtColor: AppColors.blackColor),

                  addHeight(24)
                ],
              ).marginSymmetric(horizontal: 16),
            )
                    : Center(child: addText600('No detail found')))


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
            color: AppColors.textColor3, fontSize: 14),

        Container(
            constraints: BoxConstraints(maxWidth: 260),
            child: addText500('$subTitle', fontFamily: 'Manrope',
                color: subTitleColor,
                maxLines: 2,
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
