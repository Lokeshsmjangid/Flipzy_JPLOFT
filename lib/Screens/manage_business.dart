import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/repos/get_business_profile_repo.dart';
import 'package:flipzy/Screens/order_management_screens/order_list_screen.dart';
import 'package:flipzy/Screens/product_management.dart';
import 'package:flipzy/Screens/withdrawl/wallet_management.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'boost_product.dart';

class ManageBusiness extends StatefulWidget {
  const ManageBusiness({super.key});

  @override
  State<ManageBusiness> createState() => _ManageBusinessState();
}

class _ManageBusinessState extends State<ManageBusiness> {
  CommonModelResponse response =CommonModelResponse();
  dynamic totalAmount = 0;
  dynamic totalActive = 0;
  dynamic totalorder = 0;

  fetchBusinessProfile() async{
    await businessProfileApi().then((value){

      totalAmount = value.totalAmount??0;
      totalActive = value.totalActive??0;
      totalorder = value.totalorder??0;
      setState(() {});
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask((){
      fetchBusinessProfile();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
        appBar: customAppBar(
          backgroundColor: AppColors.bgColor,
          leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
          leadingIcon: Container(
            // constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
              margin: const EdgeInsets.only(right: 15, top: 10, ),
              // height: 30, width: 30,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: AppColors.,
              ),
              // child: IconButton(
              //   onPressed: () {
              //     Get.back();
              //   },
              //   icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blackColor,),),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  AppAssets.homeLogoImg,
                  // color: AppColors.blackColor,
                  width: 15,
                  height: 15,
                ),
              ),
            /*child: SvgPicture.asset(
                AppAssets.homeLogoImg,
                // color: AppColors.blackColor,
                width: 15,
                height: 15,
              )*/
          ),
          centerTitle: false,
          titleTxt: "",
          titleColor: AppColors.blackColor,
          titleFontSize: 18,
          actionItems: [

            Container(
              width: MediaQuery.of(context).size.width * 0.12,
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(AppAssets.brandImage),
                // child: Image.network(
                //   AppAssets.demoProfileImageUrl ,
                //   // "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                //   width: 50, height: 50,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            const SizedBox(width: 10,),
          ],
          bottomLine: false,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.armyGreenColor,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // margin: EdgeInsets.all(5),
                            height: 80, width: 80,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(color: AppColors.blackColor, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(AppAssets.brandImage),
                              // child: Image.network(
                              //   AppAssets.demoProfileImageUrl ,
                              //   // "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                              //   width: 50, height: 50,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 20,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.pinkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: addText700("20%",
                                color: AppColors.redColor, fontSize: 11, ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: addText700("Complete Your Business Profile", maxLines: 2, color: AppColors.whiteColor, fontSize: 20)),

                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        if(AuthData().userModel?.userType!.toLowerCase() !='user'){
                          Get.toNamed(AppRoutes.businessProfileScreen)?.then((value){
                            Future.microtask((){
                              setState((){
                                AuthData().getLoginData();
                              }) ;

                            });
                          });
                        }
                      },
                      child: Container(
                        height: 25, width: 25,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:  SvgPicture.asset(
                          AppAssets.diagonalArrowIc,
                          // color: AppColors.blackColor,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: addText500("Available Balance", maxLines: 2, color: AppColors.blackColor, fontSize: 15)
                  ),
                  SizedBox(height: 20,),
                  addText700("₦${totalAmount}", maxLines: 2, color: AppColors.blackColor, fontSize: 40,fontFamily: ''),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(WalletManagement());
                      },
                      child: Container(
                        height: 25, width: 25,
                        // margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          // color: AppColors.greenColor,
                          shape: BoxShape.circle,
                        ),
                        child:  SvgPicture.asset(
                          AppAssets.greenDiagonalArrowIc,
                          // color: AppColors.whiteColor,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 160,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: addText500("Active Product", maxLines: 2, color: AppColors.blackColor, fontSize: 15)
                        ),
                        addHeight(20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     addText700("20", maxLines: 2, color: AppColors.blackColor, fontSize: 40),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Get.to(ProductManagement(fromScreen: "ManageBusiness",));
                        //       },
                        //       child: Container(
                        //         height: 25, width: 25,
                        //         // margin: EdgeInsets.only(right: 20),
                        //         decoration: BoxDecoration(
                        //           // color: AppColors.greenColor,
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child:  SvgPicture.asset(
                        //           AppAssets.greenDiagonalArrowIc,
                        //           // color: AppColors.whiteColor,
                        //
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: addText700("${totalActive}", maxLines: 2, color: AppColors.blackColor, fontSize: 40)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(ProductManagement(fromScreen: "ManageBusiness",));
                              Get.toNamed(AppRoutes.allBoostProduct,arguments: {'selectedBox':2});
                            },
                            child: Container(
                              height: 25, width: 25,
                              // margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                // color: AppColors.greenColor,
                                shape: BoxShape.circle,
                              ),
                              child:  SvgPicture.asset(
                                AppAssets.greenDiagonalArrowIc,
                                // color: AppColors.whiteColor,

                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 160,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: addText500("Order Management", maxLines: 2, color: AppColors.blackColor, fontSize: 14)
                        ),
                        SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     addText700("20", maxLines: 2, color: AppColors.blackColor, fontSize: 40),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Get.to(ProductManagement(fromScreen: "ManageBusiness",));
                        //       },
                        //       child: Container(
                        //         height: 25, width: 25,
                        //         // margin: EdgeInsets.only(right: 20),
                        //         decoration: BoxDecoration(
                        //           // color: AppColors.greenColor,
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child:  SvgPicture.asset(
                        //           AppAssets.greenDiagonalArrowIc,
                        //           // color: AppColors.whiteColor,
                        //
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Align(
                            alignment: Alignment.bottomLeft,
                            child: addText700("$totalorder", maxLines: 2, color: AppColors.blackColor, fontSize: 40)),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.orderListScreen,arguments: {'is_order_history':false,'userType':'Seller'});
                            },
                            child: Container(
                              height: 25, width: 25,
                              // margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                // color: AppColors.greenColor,
                                shape: BoxShape.circle,
                              ),
                              child:  SvgPicture.asset(
                                AppAssets.greenDiagonalArrowIc,
                                // color: AppColors.whiteColor,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            // All And boost Products
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.myProductsScreen);
                    },
                    child: Container(
                      // height: 160,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: addText500("My Products", maxLines: 2, color: AppColors.blackColor, fontSize: 15)
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.allBoostProduct,arguments: {'selectedBox':1});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: addText500("Boost Products", maxLines: 2, color: AppColors.blackColor, fontSize: 14)
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
