import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Screens/boost_product_screen.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/controllers/boostProduct_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/app_color.dart';

class AllBoostProduct extends StatelessWidget {
  const AllBoostProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoostProductController>(
        init: BoostProductController(),
        builder: (contt) {
      return Scaffold(
        backgroundColor: AppColors.lightGreyColor,
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
          titleTxt: "Boost Product's",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
        ),

        body : SafeArea(
          child: Column(
            children: [
//SearchTxtForm
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: CustomTextField(
                    // borderRadius: 30,
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
                      contt.deBounce.run(() {
                        contt.fetchBoostListData(searchValue: val);
                      });
                    },
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  build_product_box(contt,selectedBox: 1,boxName: 'Boosted',boxCount: '${contt.boostedCount??0}',onTap: (){
                    contt.selectedBox=1;
                    contt.update();
                  }),
                  build_product_box(contt,selectedBox: 2,boxName: 'Active',boxCount: '${contt.activeCount??0}',onTap: (){
                    contt.selectedBox=2;
                    contt.update();
                  }),
                  build_product_box(contt,selectedBox: 3,boxName: 'Total',boxCount: '${contt.allCount??0}',onTap: (){
                    contt.selectedBox=3;
                    contt.update();
                  }),
                ],
              ).marginSymmetric(horizontal: 20),

              addHeight(20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 300,
                  // height: MediaQuery.of(context).size.height * 0.80,/**/

                  child:  contt.isDataLoading
                      ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                      : contt.modelResponse.data!=null && contt.modelResponse.data!.productsList!=null
                      ? ListView(
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
                          itemCount: contt.selectedBox==1?contt.modelResponse.data!.productsList!.boostProducts!.length:contt.selectedBox==2?contt.modelResponse.data!.productsList!.activeProducts!.length:contt.selectedBox==3?contt.modelResponse.data!.productsList!.totalProducts!.length:0,
                          itemBuilder: (context, index) {
                            Product? item =
                            contt.selectedBox==1 ? contt.modelResponse.data!.productsList!.boostProducts![index]:
                            contt.selectedBox==2 ? contt.modelResponse.data!.productsList!.activeProducts![index]:
                            contt.selectedBox==3 ? contt.modelResponse.data!.productsList!.totalProducts![index]:null;
                            return GestureDetector(
                              onTap: () {
                                // print('object');
                                // Get.to(BoostProductScreen());

                              },
                              child: Container(
                                  height: 270,

                                  width: MediaQuery.of(context).size.width * 0.40,
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor, //contt.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
                                    border: Border.all(
                                      color: AppColors.greyColor,
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
                                    height: 142, width: 142,
                                    decoration: BoxDecoration(
                                      color: AppColors.containerBorderColor,
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
                                            child: CachedImageCircle2(
                                                isCircular: false,fit: BoxFit.fill,
                                                imageUrl: item!.productImages!.isNotEmpty?'${item.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                      addHeight(1.h),

                                      addText500("${item.productName?.capitalize??''}",
                                          color: AppColors.blackColor, fontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis,fontFamily: 'Manrope' ),

                                      addHeight(0.5.h),


                                      if(contt.selectedBox==1)
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.18,
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            // color: AppColors.pinkColor,
                                            color: item.boostProduct![0].status?.toLowerCase()=='pending' ? Color(0xffF9F0D8) : AppColors.buttonColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: addText400(
                                              "${item.boostProduct![0].status}",
                                              color: item.boostProduct![0].status?.toLowerCase()=='pending'
                                                  ? Color(0xffBF9628):AppColors.darkGreenColor, fontSize: 10, ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            );
                          }
                      ),
                      // Visibility(
                      //   visible: fromScreen != "DashBoard" ? true : false,
                      //   child: Container(
                      //     margin: EdgeInsets.only(bottom: 50),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(30) ,
                      //       border: Border.all(color: AppColors.greyColor),
                      //     ),
                      //     child: Container(
                      //       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //       decoration: BoxDecoration(
                      //         color: Colors.transparent,
                      //         borderRadius: BorderRadius.circular(30) ,
                      //       ),
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
                      //                 color: AppColors.blackColor,
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
                      //       // child: Row(
                      //       //   children: [
                      //       //     Expanded(
                      //       //       child: GestureDetector(
                      //       //         onTap: () {},
                      //       //         child: Container(
                      //       //           alignment: Alignment.center,
                      //       //           width: double.infinity,
                      //       //           height: 50,
                      //       //           padding: EdgeInsets.all(10),
                      //       //           decoration: BoxDecoration(
                      //       //             color: AppColors.primaryColor,
                      //       //             // border: Border.all(
                      //       //             //   color: AppColors.orangeColor,
                      //       //             //   width: 1.5,
                      //       //             // ),
                      //       //             borderRadius: BorderRadius.circular(40),
                      //       //           ),
                      //       //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //       //             children: [
                      //       //               SvgPicture.asset(
                      //       //                 AppAssets.addIC ,
                      //       //                 color: AppColors.whiteColor,
                      //       //                 fit: BoxFit.contain,
                      //       //                 // width: 21,
                      //       //                 // height: 20,
                      //       //               ),
                      //       //               SizedBox(width: 5,),
                      //       //               addText700("Add New",
                      //       //                 color: AppColors.blackColor, fontSize: 20, ),
                      //       //             ],
                      //       //           ),
                      //       //         ),
                      //       //       ),
                      //       //     ),
                      //       //     SizedBox(width: 10,),
                      //       //
                      //       //     Expanded(
                      //       //       child: GestureDetector(
                      //       //         onTap: () {
                      //       //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                      //       //         },
                      //       //         child: Container(
                      //       //           alignment: Alignment.center,
                      //       //           width: double.infinity,
                      //       //           height: 50,
                      //       //           padding: EdgeInsets.all(10),
                      //       //           decoration: BoxDecoration(
                      //       //             color: AppColors.primaryColor,
                      //       //             // border: Border.all(
                      //       //             //   color: AppColors.orangeColor,
                      //       //             //   width: 1.5,
                      //       //             // ),
                      //       //             borderRadius: BorderRadius.circular(40),
                      //       //           ),
                      //       //           child: Row(
                      //       //             mainAxisAlignment: MainAxisAlignment.center,
                      //       //             children: [
                      //       //               SvgPicture.asset(
                      //       //                 AppAssets.filterIc ,
                      //       //                 color: AppColors.whiteColor,
                      //       //                 fit: BoxFit.contain,
                      //       //                 // width: 21,
                      //       //                 // height: 20,
                      //       //               ),
                      //       //               SizedBox(width: 5,),
                      //       //               addText700("Filter",
                      //       //                 color: AppColors.blackColor, fontSize: 20, ),
                      //       //             ],
                      //       //           ),
                      //       //         ),
                      //       //       ),
                      //       //     ),
                      //       //   ],
                      //       // ),
                      //     ),
                      //   ),
                      // ),


                      // Visibility(
                      //   visible: fromScreen == "DashBoard" ? true : false,
                      //   child: Container(
                      //       margin: EdgeInsets.only(bottom: 50),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(30) ,
                      //         border: Border.all(color: AppColors.greyColor),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: Container(
                      //               margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.transparent,
                      //                 borderRadius: BorderRadius.circular(30) ,
                      //               ),
                      //               child: GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   alignment: Alignment.center,
                      //                   width: double.infinity,
                      //                   height: 50,
                      //                   padding: EdgeInsets.all(10),
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.greyColor,
                      //                     // border: Border.all(
                      //                     //   color: AppColors.orangeColor,
                      //                     //   width: 1.5,
                      //                     // ),
                      //                     borderRadius: BorderRadius.circular(40),
                      //                   ),
                      //                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       SvgPicture.asset(
                      //                         AppAssets.addIC ,
                      //                         color: AppColors.blackColor,
                      //                         fit: BoxFit.contain,
                      //                         // width: 21,
                      //                         // height: 20,
                      //                       ),
                      //                       SizedBox(width: 5,),
                      //                       addText700("Add New",
                      //                         color: AppColors.blackColor, fontSize: 20, ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               // child: Row(
                      //               //   children: [
                      //               //     Expanded(
                      //               //       child: GestureDetector(
                      //               //         onTap: () {},
                      //               //         child: Container(
                      //               //           alignment: Alignment.center,
                      //               //           width: double.infinity,
                      //               //           height: 50,
                      //               //           padding: EdgeInsets.all(10),
                      //               //           decoration: BoxDecoration(
                      //               //             color: AppColors.primaryColor,
                      //               //             // border: Border.all(
                      //               //             //   color: AppColors.orangeColor,
                      //               //             //   width: 1.5,
                      //               //             // ),
                      //               //             borderRadius: BorderRadius.circular(40),
                      //               //           ),
                      //               //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //               //             children: [
                      //               //               SvgPicture.asset(
                      //               //                 AppAssets.addIC ,
                      //               //                 color: AppColors.whiteColor,
                      //               //                 fit: BoxFit.contain,
                      //               //                 // width: 21,
                      //               //                 // height: 20,
                      //               //               ),
                      //               //               SizedBox(width: 5,),
                      //               //               addText700("Add New",
                      //               //                 color: AppColors.blackColor, fontSize: 20, ),
                      //               //             ],
                      //               //           ),
                      //               //         ),
                      //               //       ),
                      //               //     ),
                      //               //     SizedBox(width: 10,),
                      //               //
                      //               //     Expanded(
                      //               //       child: GestureDetector(
                      //               //         onTap: () {
                      //               //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                      //               //         },
                      //               //         child: Container(
                      //               //           alignment: Alignment.center,
                      //               //           width: double.infinity,
                      //               //           height: 50,
                      //               //           padding: EdgeInsets.all(10),
                      //               //           decoration: BoxDecoration(
                      //               //             color: AppColors.primaryColor,
                      //               //             // border: Border.all(
                      //               //             //   color: AppColors.orangeColor,
                      //               //             //   width: 1.5,
                      //               //             // ),
                      //               //             borderRadius: BorderRadius.circular(40),
                      //               //           ),
                      //               //           child: Row(
                      //               //             mainAxisAlignment: MainAxisAlignment.center,
                      //               //             children: [
                      //               //               SvgPicture.asset(
                      //               //                 AppAssets.filterIc ,
                      //               //                 color: AppColors.whiteColor,
                      //               //                 fit: BoxFit.contain,
                      //               //                 // width: 21,
                      //               //                 // height: 20,
                      //               //               ),
                      //               //               SizedBox(width: 5,),
                      //               //               addText700("Filter",
                      //               //                 color: AppColors.blackColor, fontSize: 20, ),
                      //               //             ],
                      //               //           ),
                      //               //         ),
                      //               //       ),
                      //               //     ),
                      //               //   ],
                      //               // ),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: Container(
                      //               margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.transparent,
                      //                 borderRadius: BorderRadius.circular(30) ,
                      //               ),
                      //               child: GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   alignment: Alignment.center,
                      //                   width: double.infinity,
                      //                   height: 50,
                      //                   padding: EdgeInsets.all(10),
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.primaryColor,
                      //                     // border: Border.all(
                      //                     //   color: AppColors.orangeColor,
                      //                     //   width: 1.5,
                      //                     // ),
                      //                     borderRadius: BorderRadius.circular(40),
                      //                   ),
                      //                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       SvgPicture.asset(
                      //                         AppAssets.filterIc ,
                      //                         color: AppColors.blackColor,
                      //                         fit: BoxFit.contain,
                      //                         // width: 21,
                      //                         // height: 20,
                      //                       ),
                      //                       SizedBox(width: 5,),
                      //                       addText700("Filter",
                      //                         color: AppColors.blackColor, fontSize: 20, ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               // child: Row(
                      //               //   children: [
                      //               //     Expanded(
                      //               //       child: GestureDetector(
                      //               //         onTap: () {},
                      //               //         child: Container(
                      //               //           alignment: Alignment.center,
                      //               //           width: double.infinity,
                      //               //           height: 50,
                      //               //           padding: EdgeInsets.all(10),
                      //               //           decoration: BoxDecoration(
                      //               //             color: AppColors.primaryColor,
                      //               //             // border: Border.all(
                      //               //             //   color: AppColors.orangeColor,
                      //               //             //   width: 1.5,
                      //               //             // ),
                      //               //             borderRadius: BorderRadius.circular(40),
                      //               //           ),
                      //               //           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //               //             children: [
                      //               //               SvgPicture.asset(
                      //               //                 AppAssets.addIC ,
                      //               //                 color: AppColors.whiteColor,
                      //               //                 fit: BoxFit.contain,
                      //               //                 // width: 21,
                      //               //                 // height: 20,
                      //               //               ),
                      //               //               SizedBox(width: 5,),
                      //               //               addText700("Add New",
                      //               //                 color: AppColors.blackColor, fontSize: 20, ),
                      //               //             ],
                      //               //           ),
                      //               //         ),
                      //               //       ),
                      //               //     ),
                      //               //     SizedBox(width: 10,),
                      //               //
                      //               //     Expanded(
                      //               //       child: GestureDetector(
                      //               //         onTap: () {
                      //               //           FilterBottomsheet.show(context, onTap1: () => Get.back(), onTap2: () => Get.back());
                      //               //         },
                      //               //         child: Container(
                      //               //           alignment: Alignment.center,
                      //               //           width: double.infinity,
                      //               //           height: 50,
                      //               //           padding: EdgeInsets.all(10),
                      //               //           decoration: BoxDecoration(
                      //               //             color: AppColors.primaryColor,
                      //               //             // border: Border.all(
                      //               //             //   color: AppColors.orangeColor,
                      //               //             //   width: 1.5,
                      //               //             // ),
                      //               //             borderRadius: BorderRadius.circular(40),
                      //               //           ),
                      //               //           child: Row(
                      //               //             mainAxisAlignment: MainAxisAlignment.center,
                      //               //             children: [
                      //               //               SvgPicture.asset(
                      //               //                 AppAssets.filterIc ,
                      //               //                 color: AppColors.whiteColor,
                      //               //                 fit: BoxFit.contain,
                      //               //                 // width: 21,
                      //               //                 // height: 20,
                      //               //               ),
                      //               //               SizedBox(width: 5,),
                      //               //               addText700("Filter",
                      //               //                 color: AppColors.blackColor, fontSize: 20, ),
                      //               //             ],
                      //               //           ),
                      //               //         ),
                      //               //       ),
                      //               //     ),
                      //               //   ],
                      //               // ),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //   ),
                      // ),
                    ],
                  ) : Center(child: addText500('No Data Found')),
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








//         body: Column(
//           children: [
// //SearchTxtForm
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Search Product Name",
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30), // Circular edges
//                     borderSide: BorderSide.none, // Remove default border
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.blue, width: 2),
//                   ),
//                   suffixIcon: Container(
//                     margin: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
//                     padding: const EdgeInsets.all(10),
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       border: Border.all(
//                         // color: AppColors.primaryColor,
//                         width: 1.5,
//                       ),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: SvgPicture.asset(
//                       AppAssets.searchIcon,
//                       color: AppColors.whiteColor,
//                       width: 21,
//                       height: 20,
//                     ),
//                   ),
//                 ),
//
//               ),
//             ),
// //
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.only(left: 10),
//                 height: MediaQuery.of(context).size.height * 0.50,
//
//                 child: GridView.builder(
//                   // gridDelegate: SliverGridDelegate(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // 2 items per row
//                       crossAxisSpacing: 2,
//                       mainAxisSpacing: 2,
//                       childAspectRatio: 0.9, // Adjust height-to-width ratio
//                     ),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: cntrl.allItems.length ?? 0,
//                     itemBuilder: (context, item) {
//                       // String? input =  contt.servicesModel.data?[item].title?.replaceAll(" ", "\n") ;
//                       return GestureDetector(
//                         onTap: () {
//                         },
//                         child: Container(
//                           // height: 100,
//                           // width: MediaQuery.of(context).size.width*0.4,
//                           // width: 150,
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.whiteColor, //contt.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
//                               border: Border.all(
//                                 color: AppColors.blackColor,
//                                 width: 1,
//                               ),
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 Container(
//                                   height: MediaQuery.of(context).size.height * 0.20,
//                                   width: MediaQuery.of(context).size.width * 0.42,
//                                   margin: EdgeInsets.only(bottom: 10),
//                                   decoration: BoxDecoration(
//                                     // color: Colors.red,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: SizedBox(
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       child: Image.network(
//                                         AppAssets.demoIphoneImageUrl,
//                                         fit: BoxFit.cover,
//                                       ),
//                                       // child: SvgPicture.asset(
//                                       //   // AppAssets.iphoneImg,
//                                       //   AppAssets.electronicItem,
//                                       //   // contt.featuredItems[item].images,
//                                       //   fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 5,),
//
//                                 Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // SizedBox(width: 10,),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         addText700("₹${cntrl.allItems[item].price}",
//                                           color: AppColors.blackColor, fontSize: 12, ),
//
//                                         Container(
//                                           constraints: BoxConstraints(maxWidth: 80) ,
//                                           child: addText400("${cntrl.allItems[item].title}",
//                                               color: AppColors.blackColor, fontSize: 11, maxLines: 1, overflow: TextOverflow.ellipsis ),
//                                         ),
//                                       ],
//                                     ),
//                                     // SizedBox(width: 5/**/,)
//                                   ],
//                                 ),
//
//                               ],
//                             )
//                         ),
//                       );
//                     }
//                 ),
//               ),
//             ),
//
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //               child: CustomTextField(
// //                 // prefixIcon: SvgPicture.asset(
// //                 //   AppAssets.searchBoxesIc,
// //                 //   color: AppColors.blackColor,
// //                 //   width: 15,
// //                 //   height: 15,
// //                 // ),
// //                 // InputDecoration(
// //                 //   hintText: "Enter text",
// //                 //   filled: true,
// //                 //   fillColor: Colors.white,
// //                 //   border: OutlineInputBorder(
// //                 //     borderRadius: BorderRadius.circular(30), // Circular edges
// //                 //     borderSide: BorderSide.none, // Remove default border
// //                 //   ),
// //                 //   enabledBorder: OutlineInputBorder(
// //                 //     borderRadius: BorderRadius.circular(30),
// //                 //     borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
// //                 //   ),
// //                 //   focusedBorder: OutlineInputBorder(
// //                 //     borderRadius: BorderRadius.circular(30),
// //                 //     borderSide: BorderSide(color: Colors.blue, width: 2),
// //                 //   ),
// //                 // ),
// //                 hintText: "Search Product Name",
// //                 fillColor: AppColors.whiteColor,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(100), // Circular edges
// //                   borderSide: BorderSide.none, // Remove default border
// //                 ),
// //
// //                 suffixIcon: Container(
// //                   margin: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
// //                   padding: const EdgeInsets.all(10),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primaryColor,
// //                     border: Border.all(
// //                       // color: AppColors.primaryColor,
// //                       width: 1.5,
// //                     ),
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: SvgPicture.asset(
// //                     AppAssets.searchIcon,
// //                     color: AppColors.whiteColor,
// //                     width: 31,
// //                     height: 30,
// //                   ),
// //                 ),
// //               ),
// //             ),
//           ],
//         ),
      );
     }
    );
  }

  build_product_box(BoostProductController contt, {void Function()? onTap,int? selectedBox, String? boxName,String? boxCount,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 112,
        width: 100,
        decoration: BoxDecoration(
            color: selectedBox==contt.selectedBox?AppColors.armyGreenColor: Colors.white,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: AppColors.containerBorderColor,width: 2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(selectedBox==1?AppAssets.boostRocket:selectedBox==2?AppAssets.active:AppAssets.all,height: 23,width: 23,color: selectedBox==contt.selectedBox
                ? AppColors.whiteColor:AppColors.armyGreenColor,),
            addText500('$boxName',color: selectedBox==contt.selectedBox
                ? AppColors.whiteColor:AppColors.armyGreenColor,),
            addText500('$boxCount',color: selectedBox==contt.selectedBox
                ? AppColors.whiteColor:AppColors.armyGreenColor,),
          ],
        ),

      ),
    );
  }
}
