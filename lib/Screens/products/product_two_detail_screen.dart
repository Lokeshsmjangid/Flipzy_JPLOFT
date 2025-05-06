import 'package:flipzy/Screens/makeOfferChat.dart';
import 'package:flipzy/Screens/seller_profile.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../cart_screen.dart';
import '../seller_two_profile.dart';

class ProductDetailTwoScreen extends StatelessWidget {
  ProductDetailTwoScreen({super.key});

  final List<String> imageUrls = [
    "https://cdn.mos.cms.futurecdn.net/yDn3ZSXu9eSBxmXQDZ4PCF-1200-80.jpg",
    "https://inspireonline.in/cdn/shop/files/iPhone_15_Pink_PDP_Image_Position-1__en-IN.jpg?v=1694605206",
    "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-13-01.jpg",
    "https://cdn.mos.cms.futurecdn.net/yDn3ZSXu9eSBxmXQDZ4PCF-1200-80.jpg",
    "https://inspireonline.in/cdn/shop/files/iPhone_15_Pink_PDP_Image_Position-1__en-IN.jpg?v=1694605206",
    "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-13-01.jpg",
  ];

  final List<String> imagesList = [
    AppAssets.smallIphoneImg1,
    AppAssets.smallIphoneImg2,
    AppAssets.smallIphoneImg3,
    AppAssets.smallIphoneImg4,
  ];

  int _currentIndex = 0;

  // Navigate to the previous image.
  void _goToPreviousImage() {
     _currentIndex = (_currentIndex - 1 + imageUrls.length) % imageUrls.length;
  }

  void _goToNextImage() {
      _currentIndex = (_currentIndex + 1) % imageUrls.length;
  }

  void _onThumbnailTap(int index) {
      _currentIndex = index;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Column(
        children: [
          addHeight(44),
          backAppBar(
              title: "Iphone",
              onTapBack: () {
            Get.back();
          }),

          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                addHeight(14),
                // https://cdn.mos.cms.futurecdn.net/yDn3ZSXu9eSBxmXQDZ4PCF-1200-80.jpg
                // SizedBox(
                //     height: 200,
                //     child: BorderedContainer(isBorder: false,
                //         child: Center(child: addText500('Image')))),

                // Container(
                //   width: Get.height * 0.3,
                //   height: Get.height * 0.2,
                //   padding: EdgeInsets.symmetric(vertical: 5),
                //   margin: EdgeInsets.only(left: 15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     // shape: BoxShape.circle,
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(20),
                //     child: Image.network(
                //       "https://cdn.mos.cms.futurecdn.net/yDn3ZSXu9eSBxmXQDZ4PCF-1200-80.jpg",
                //       // width: 50, height: 50,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _goToPreviousImage,
                      icon: Icon(Icons.keyboard_arrow_left, size: 32),
                    ),
                    // Main image container
                    Container(
                      width: 200, // Adjust as needed
                      height: 200, // Adjust as needed
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(AppAssets.bigIphoneProductDetail),
                      // child: Image.network(
                      //   imageUrls[_currentIndex],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    IconButton(
                      onPressed: _goToNextImage,
                      icon: Icon(Icons.keyboard_arrow_right, size: 32),
                    ),
                  ],
                ),

              SizedBox(height: 10,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagesList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String imageUrl = entry.value;
                    return SizedBox(
                        height: 80, width: 80,
                        child: Image.asset(imageUrl).marginOnly(right: 10)
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
                  }).toList(), ), ),


                addHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addText700('₦ 60,000',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 24),
                    SvgPicture.asset(AppAssets.cartIC),                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,child: addText700('Apple iPhone 16 (White, 128 GB)',fontFamily: 'Manrope',color: AppColors.textColor3,fontSize: 18)),
                addHeight(20),

                BorderedContainer(
                    padding: 20,
                    isBorder: false,
                    bGColor: AppColors.greenColor.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // addHeight(10),
                        addText700('Details',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 16),
                        addHeight(12),
                        build_tile(title: 'Brand',subTitle: 'Apple',subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        build_tile(title: 'Operating System',subTitle: 'iOS 18',subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        build_tile(title: 'Internal Storage',subTitle: '256 GB',subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        build_tile(title: 'Network Type',subTitle: "5G, 4G Volte, 4G, 3G, 2G",subTitleColor: Colors.black),

                        addHeight(12),

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
                        addText700('Description',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 16),
                        addHeight(12),

                        addText500('We Sale 1-2 Days used product just like new, mostly warranty around 4-5month product is genuine no scratch no dirty with complete accessories, we give gst invoice on current date with customer name. Warranty as per activation date. We are online e-commerce seller at Flipkart and Amazon. These products are online return used product, so We sale these products lowest price with hu all accessories and box. We sale genuine brands products remaining warranty claim by customer to brand authorised service center',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

                        addHeight(4),
                      ],
                    )
                ),
                addHeight(10),

                GestureDetector(
                  onTap: () {
                    Get.to(SellerTwoProfileScreen());
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
                            child: Image.asset(AppAssets.notificationProfileIC),
                            // child: Image.network(
                            //   "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                            //   // width: 50, height: 50,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        SizedBox(width: 10,),

                        addText700('Amelia-Rose',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

                        Spacer(),

                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.blackColor),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.starImage,
                                  fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                ),
                                addText400(' 4.0',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
                              ],
                            ),
                          ),

                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ),

                addHeight(10),

                addText500('10 people have purchase this product in past',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

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
                          onTap : () {
                            Get.to(MakeOfferChatScreen());
                          },
                          child: Container(

                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
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
                                  fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                ),
                                SizedBox(width: 10,),
                                addText700('Make Offer',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(

                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
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
                                  fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                ),
                                SizedBox(width: 10,),
                                addText700('Chat',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

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
                    Get.to(CartScreen());
                  },
                  buttonText: 'Buy Now', buttonTxtColor: AppColors.blackColor,),

                addHeight(24)



              ],
            ).marginSymmetric(horizontal: 16),
          ))


        ],
      ),
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

}
