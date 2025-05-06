import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/controllers/ProductManagementController.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/dialogues/filter_bottomsheet.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductManagement extends StatelessWidget {
  String fromScreen;
  ProductManagement({super.key, this.fromScreen = ""});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductManagementController>(
        init: ProductManagementController(),
        builder: (contt) {
          return Scaffold(
            backgroundColor: AppColors.lightGreyColor,
            appBar: fromScreen == "DashBoard"
                ? null
                : customAppBar(
              backgroundColor: AppColors.bgColor,
              leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
              leadingIcon: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                    addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
                  ],
                ).marginOnly(left: 12),
              ),
              centerTitle: true,
              titleTxt: "Products",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              actionItems: [
              ],
              bottomLine: true,
            ),
            extendBody: true,
            // bottomNavigationBar: Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(30) ,
            //     border: Border.all(color: AppColors.greyColor),
            //   ),
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     decoration: BoxDecoration(
            //       color: Colors.transparent,
            //       borderRadius: BorderRadius.circular(30) ,
            //     ),
            //     child: GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         alignment: Alignment.center,
            //         width: double.infinity,
            //         height: 50,
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: AppColors.primaryColor,
            //           // border: Border.all(
            //           //   color: AppColors.orangeColor,
            //           //   width: 1.5,
            //           // ),
            //           borderRadius: BorderRadius.circular(40),
            //         ),
            //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             SvgPicture.asset(
            //               AppAssets.addIC ,
            //               color: AppColors.whiteColor,
            //               fit: BoxFit.contain,
            //               // width: 21,
            //               // height: 20,
            //             ),
            //             SizedBox(width: 5,),
            //             addText700("Add New",
            //               color: AppColors.blackColor, fontSize: 20, ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     // child: Row(
            //     //   children: [
            //     //     Expanded(
            //     //       child: GestureDetector(
            //     //         onTap: () {},
            //     //         child: Container(
            //     //           alignment: Alignment.center,
            //     //           width: double.infinity,
            //     //           height: 50,
            //     //           padding: EdgeInsets.all(10),
            //     //           decoration: BoxDecoration(
            //     //             color: AppColors.primaryColor,
            //     //             // border: Border.all(
            //     //             //   color: AppColors.orangeColor,
            //     //             //   width: 1.5,
            //     //             // ),
            //     //             borderRadius: BorderRadius.circular(40),
            //     //           ),
            //     //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
            //     //             children: [
            //     //               SvgPicture.asset(
            //     //                 AppAssets.addIC ,
            //     //                 color: AppColors.whiteColor,
            //     //                 fit: BoxFit.contain,
            //     //                 // width: 21,
            //     //                 // height: 20,
            //     //               ),
            //     //               SizedBox(width: 5,),
            //     //               addText700("Add New",
            //     //                 color: AppColors.blackColor, fontSize: 20, ),
            //     //             ],
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     ),
            //     //     SizedBox(width: 10,),
            //     //
            //     //     Expanded(
            //     //       child: GestureDetector(
            //     //         onTap: () {
            //     //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
            //     //         },
            //     //         child: Container(
            //     //           alignment: Alignment.center,
            //     //           width: double.infinity,
            //     //           height: 50,
            //     //           padding: EdgeInsets.all(10),
            //     //           decoration: BoxDecoration(
            //     //             color: AppColors.primaryColor,
            //     //             // border: Border.all(
            //     //             //   color: AppColors.orangeColor,
            //     //             //   width: 1.5,
            //     //             // ),
            //     //             borderRadius: BorderRadius.circular(40),
            //     //           ),
            //     //           child: Row(
            //     //             mainAxisAlignment: MainAxisAlignment.center,
            //     //             children: [
            //     //               SvgPicture.asset(
            //     //                 AppAssets.filterIc ,
            //     //                 color: AppColors.whiteColor,
            //     //                 fit: BoxFit.contain,
            //     //                 // width: 21,
            //     //                 // height: 20,
            //     //               ),
            //     //               SizedBox(width: 5,),
            //     //               addText700("Filter",
            //     //                 color: AppColors.blackColor, fontSize: 20, ),
            //     //             ],
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //   ),
            // ),
            bottomNavigationBar: fromScreen == "ManageBusiness"
                ? BorderedContainer(radius: 10000,
                              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          // border: Border.all(
                          //   color: AppColors.orangeColor,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.addIC ,
                              color: AppColors.blackColor,
                              fit: BoxFit.contain,
                              // width: 21,
                              // height: 20,
                            ),
                            SizedBox(width: 5,),
                            addText700("Add New",
                              color: AppColors.blackColor, fontSize: 20, ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.darkGreenColor,
                          // border: Border.all(
                          //   color: AppColors.orangeColor,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.filterIc ,
                              color: AppColors.whiteColor,
                              fit: BoxFit.contain,
                              // width: 21,
                              // height: 20,
                            ),
                            SizedBox(width: 5,),
                            addText700("Filter",
                              color: AppColors.whiteColor, fontSize: 20, ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                              ),
                            ).marginSymmetric(horizontal: 12,vertical: 5)
                : null,
            body: SafeArea(
              child: Column(
                children: [
//SearchTxtForm
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: CustomTextField(
                      hintText: 'Search Product Name',
                      suffixIcon: SvgPicture.asset(
                        AppAssets.searchIcon,
                        color: AppColors.blackColor,
                        // width: 20,
                        // height: 19,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 300,
                      // height: MediaQuery.of(context).size.height * 0.80,/**/

                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          GridView.builder(

                            // gridDelegate: SliverGridDelegate(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 1,

                                childAspectRatio: 0.8, // Adjust height-to-width ratio
                              ),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,

                              itemCount: contt.featuredItems.length ?? 0,
                              itemBuilder: (context, item) {
                                // String? input =  contt.servicesModel.data?[item].title?.replaceAll(" ", "\n") ;
                                return GestureDetector(
                                  onTap: () {
                                    // Get.to(BoostProduct());
                                  },
                                  child: Container(
                                      height: 270,
                                      // width: MediaQuery.of(context).size.width*0.4,
                                      // width: 150,
                                      width: MediaQuery.of(context).size.width * 0.40,
                                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor, //contt.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
                                        border: Border.all(
                                          color: Color(0XFFEDEDED),
                                          width: 1,
                                        ),
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          addHeight(4),
                                          Container(
                                            height:147,
                                            // height: MediaQuery.of(context).size.height * 0.20,
                                            width: MediaQuery.of(context).size.width * 0.42,
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: Image.asset(AppAssets.homeScreenIphone2,fit: BoxFit.cover,),
                                                    // child: Image.network(
                                                    //     AppAssets.demoIphoneImageUrl,
                                                    // fit: BoxFit.cover,
                                                    // ),
                                                    // child: SvgPicture.asset(
                                                    //   // AppAssets.iphoneImg,
                                                    //   AppAssets.electronicItem,
                                                    //   // contt.featuredItems[item].images,
                                                    //   fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                                    // ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: item%2 == 0 ? true : false,
                                                  child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.18,
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      margin: EdgeInsets.only(bottom: 15, right: 5),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whiteColor,
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(right: 5),
                                                            child: SvgPicture.asset(
                                                              AppAssets.boostRocket,
                                                              fit: BoxFit.contain,
                                                            ),
                                                          ),
                                                          addText400("Boost",
                                                            color: AppColors.blackColor, fontSize: 12, ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 5,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  addText700("₦${contt.featuredItems[item].price}",
                                                    color: AppColors.blackColor, fontSize: 12, ),

                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: 80) ,
                                                    child: addText400("${contt.featuredItems[item].title}",
                                                        color: AppColors.blackColor, fontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis ),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap : () {
                                                      DeleteProductDialog.show(context,
                                                          onTap1: (){

                                                        Get.back();
                                                        contt.featuredItems.removeAt(item);
                                                        contt.update();
                                                          },
                                                          onTap2: () => Get.back());
                                                    } ,
                                                    child: Container(
                                                      height: 23, width: 23,
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.appRedColor,
                                                        shape: BoxShape.circle ,
                                                      ),
                                                      margin: EdgeInsets.only(right: 5),
                                                      child: SvgPicture.asset(
                                                        AppAssets.deleteIC,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap : () {
                                                      Get.to(EditProducts());
                                                      // DeleteProductDialog.show(context,
                                                      //     onTap1: () => Get.to(EditProducts()),
                                                      //     onTap2: () => Get.back());
                                                    } ,
                                                    child: Container(
                                                      height: 23, width: 23,
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.appGreenColor,
                                                        shape: BoxShape.circle ,
                                                      ),
                                                      margin: EdgeInsets.only(right: 5),
                                                      child: SvgPicture.asset(
                                                        AppAssets.editPenIc,
                                                        // AppAssets.editPenIc,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(width: 80,)
                                            ],
                                          ),

                                        ],
                                      )
                                  ),
                                );
                              }
                          ),
                          if(fromScreen != "ManageBusiness" )
                            Visibility(
                              visible: fromScreen != "DashBoard" ? true : false,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 50),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30) ,
                                  border: Border.all(color: AppColors.greyColor),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30) ,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("object");
                                      Get.to(AddProduct())?.then((value){
                                        contt.onInit();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 50,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        // border: Border.all(
                                        //   color: AppColors.orangeColor,
                                        //   width: 1.5,
                                        // ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.addIC ,
                                            color: AppColors.blackColor,
                                            fit: BoxFit.contain,
                                            // width: 21,
                                            // height: 20,
                                          ),
                                          SizedBox(width: 5,),
                                          addText700("Add New",
                                            color: AppColors.blackColor, fontSize: 20, ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // child: Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: GestureDetector(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           alignment: Alignment.center,
                                  //           width: double.infinity,
                                  //           height: 50,
                                  //           padding: EdgeInsets.all(10),
                                  //           decoration: BoxDecoration(
                                  //             color: AppColors.primaryColor,
                                  //             // border: Border.all(
                                  //             //   color: AppColors.orangeColor,
                                  //             //   width: 1.5,
                                  //             // ),
                                  //             borderRadius: BorderRadius.circular(40),
                                  //           ),
                                  //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  //             children: [
                                  //               SvgPicture.asset(
                                  //                 AppAssets.addIC ,
                                  //                 color: AppColors.whiteColor,
                                  //                 fit: BoxFit.contain,
                                  //                 // width: 21,
                                  //                 // height: 20,
                                  //               ),
                                  //               SizedBox(width: 5,),
                                  //               addText700("Add New",
                                  //                 color: AppColors.blackColor, fontSize: 20, ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 10,),
                                  //
                                  //     Expanded(
                                  //       child: GestureDetector(
                                  //         onTap: () {
                                  //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                                  //         },
                                  //         child: Container(
                                  //           alignment: Alignment.center,
                                  //           width: double.infinity,
                                  //           height: 50,
                                  //           padding: EdgeInsets.all(10),
                                  //           decoration: BoxDecoration(
                                  //             color: AppColors.primaryColor,
                                  //             // border: Border.all(
                                  //             //   color: AppColors.orangeColor,
                                  //             //   width: 1.5,
                                  //             // ),
                                  //             borderRadius: BorderRadius.circular(40),
                                  //           ),
                                  //           child: Row(
                                  //             mainAxisAlignment: MainAxisAlignment.center,
                                  //             children: [
                                  //               SvgPicture.asset(
                                  //                 AppAssets.filterIc ,
                                  //                 color: AppColors.whiteColor,
                                  //                 fit: BoxFit.contain,
                                  //                 // width: 21,
                                  //                 // height: 20,
                                  //               ),
                                  //               SizedBox(width: 5,),
                                  //               addText700("Filter",
                                  //                 color: AppColors.blackColor, fontSize: 20, ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),


                          Visibility(
                            visible: fromScreen == "DashBoard" ? true : false,
                            child: Container(
                                margin: EdgeInsets.only(bottom: 50),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30) ,
                                  border: Border.all(color: AppColors.greyColor),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(30) ,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 50,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.greyColor,
                                              // border: Border.all(
                                              //   color: AppColors.orangeColor,
                                              //   width: 1.5,
                                              // ),
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.addIC ,
                                                  color: AppColors.blackColor,
                                                  fit: BoxFit.contain,
                                                  // width: 21,
                                                  // height: 20,
                                                ),
                                                SizedBox(width: 5,),
                                                addText700("Add New",
                                                  color: AppColors.blackColor, fontSize: 20, ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // child: Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: GestureDetector(
                                        //         onTap: () {},
                                        //         child: Container(
                                        //           alignment: Alignment.center,
                                        //           width: double.infinity,
                                        //           height: 50,
                                        //           padding: EdgeInsets.all(10),
                                        //           decoration: BoxDecoration(
                                        //             color: AppColors.primaryColor,
                                        //             // border: Border.all(
                                        //             //   color: AppColors.orangeColor,
                                        //             //   width: 1.5,
                                        //             // ),
                                        //             borderRadius: BorderRadius.circular(40),
                                        //           ),
                                        //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               SvgPicture.asset(
                                        //                 AppAssets.addIC ,
                                        //                 color: AppColors.whiteColor,
                                        //                 fit: BoxFit.contain,
                                        //                 // width: 21,
                                        //                 // height: 20,
                                        //               ),
                                        //               SizedBox(width: 5,),
                                        //               addText700("Add New",
                                        //                 color: AppColors.blackColor, fontSize: 20, ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 10,),
                                        //
                                        //     Expanded(
                                        //       child: GestureDetector(
                                        //         onTap: () {
                                        //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                                        //         },
                                        //         child: Container(
                                        //           alignment: Alignment.center,
                                        //           width: double.infinity,
                                        //           height: 50,
                                        //           padding: EdgeInsets.all(10),
                                        //           decoration: BoxDecoration(
                                        //             color: AppColors.primaryColor,
                                        //             // border: Border.all(
                                        //             //   color: AppColors.orangeColor,
                                        //             //   width: 1.5,
                                        //             // ),
                                        //             borderRadius: BorderRadius.circular(40),
                                        //           ),
                                        //           child: Row(
                                        //             mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               SvgPicture.asset(
                                        //                 AppAssets.filterIc ,
                                        //                 color: AppColors.whiteColor,
                                        //                 fit: BoxFit.contain,
                                        //                 // width: 21,
                                        //                 // height: 20,
                                        //               ),
                                        //               SizedBox(width: 5,),
                                        //               addText700("Filter",
                                        //                 color: AppColors.blackColor, fontSize: 20, ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(30) ,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 50,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              // border: Border.all(
                                              //   color: AppColors.orangeColor,
                                              //   width: 1.5,
                                              // ),
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.filterIc ,
                                                  color: AppColors.blackColor,
                                                  fit: BoxFit.contain,
                                                  // width: 21,
                                                  // height: 20,
                                                ),
                                                SizedBox(width: 5,),
                                                addText700("Filter",
                                                  color: AppColors.blackColor, fontSize: 20, ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // child: Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: GestureDetector(
                                        //         onTap: () {},
                                        //         child: Container(
                                        //           alignment: Alignment.center,
                                        //           width: double.infinity,
                                        //           height: 50,
                                        //           padding: EdgeInsets.all(10),
                                        //           decoration: BoxDecoration(
                                        //             color: AppColors.primaryColor,
                                        //             // border: Border.all(
                                        //             //   color: AppColors.orangeColor,
                                        //             //   width: 1.5,
                                        //             // ),
                                        //             borderRadius: BorderRadius.circular(40),
                                        //           ),
                                        //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               SvgPicture.asset(
                                        //                 AppAssets.addIC ,
                                        //                 color: AppColors.whiteColor,
                                        //                 fit: BoxFit.contain,
                                        //                 // width: 21,
                                        //                 // height: 20,
                                        //               ),
                                        //               SizedBox(width: 5,),
                                        //               addText700("Add New",
                                        //                 color: AppColors.blackColor, fontSize: 20, ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 10,),
                                        //
                                        //     Expanded(
                                        //       child: GestureDetector(
                                        //         onTap: () {
                                        //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                                        //         },
                                        //         child: Container(
                                        //           alignment: Alignment.center,
                                        //           width: double.infinity,
                                        //           height: 50,
                                        //           padding: EdgeInsets.all(10),
                                        //           decoration: BoxDecoration(
                                        //             color: AppColors.primaryColor,
                                        //             // border: Border.all(
                                        //             //   color: AppColors.orangeColor,
                                        //             //   width: 1.5,
                                        //             // ),
                                        //             borderRadius: BorderRadius.circular(40),
                                        //           ),
                                        //           child: Row(
                                        //             mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               SvgPicture.asset(
                                        //                 AppAssets.filterIc ,
                                        //                 color: AppColors.whiteColor,
                                        //                 fit: BoxFit.contain,
                                        //                 // width: 21,
                                        //                 // height: 20,
                                        //               ),
                                        //               SizedBox(width: 5,),
                                        //               addText700("Filter",
                                        //                 color: AppColors.blackColor, fontSize: 20, ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),



                  // SizedBox(height: 100,)

                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //               child: CustomTextField(
                  //                 // prefixIcon: SvgPicture.asset(
                  //                 //   AppAssets.searchBoxesIc,
                  //                 //   color: AppColors.blackColor,
                  //                 //   width: 15,
                  //                 //   height: 15,
                  //                 // ),
                  //                 // InputDecoration(
                  //                 //   hintText: "Enter text",
                  //                 //   filled: true,
                  //                 //   fillColor: Colors.white,
                  //                 //   border: OutlineInputBorder(
                  //                 //     borderRadius: BorderRadius.circular(30), // Circular edges
                  //                 //     borderSide: BorderSide.none, // Remove default border
                  //                 //   ),
                  //                 //   enabledBorder: OutlineInputBorder(
                  //                 //     borderRadius: BorderRadius.circular(30),
                  //                 //     borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  //                 //   ),
                  //                 //   focusedBorder: OutlineInputBorder(
                  //                 //     borderRadius: BorderRadius.circular(30),
                  //                 //     borderSide: BorderSide(color: Colors.blue, width: 2),
                  //                 //   ),
                  //                 // ),
                  //                 hintText: "Search Product Name",
                  //                 fillColor: AppColors.whiteColor,
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(100), // Circular edges
                  //                   borderSide: BorderSide.none, // Remove default border
                  //                 ),
                  //
                  //                 suffixIcon: Container(
                  //                   margin: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
                  //                   padding: const EdgeInsets.all(10),
                  //                   decoration: BoxDecoration(
                  //                     color: AppColors.primaryColor,
                  //                     border: Border.all(
                  //                       // color: AppColors.primaryColor,
                  //                       width: 1.5,
                  //                     ),
                  //                     borderRadius: BorderRadius.circular(30),
                  //                   ),
                  //                   child: SvgPicture.asset(
                  //                     AppAssets.searchIcon,
                  //                     color: AppColors.whiteColor,
                  //                     width: 31,
                  //                     height: 30,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                ],
              ),
            ),
          );
        });
  }
}
