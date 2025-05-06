import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Api/api_models/home_model_response.dart';
import '../resources/custom_text_field.dart';
import 'products/product_detail_screen.dart';

class ViewAllHomeScreen extends StatefulWidget {
  List<Product> products;
  ViewAllHomeScreen({super.key,required this.products});

  @override
  State<ViewAllHomeScreen> createState() => _ViewAllHomeScreenState();
}

class _ViewAllHomeScreenState extends State<ViewAllHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: customAppBar(
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

      body: SafeArea(
        child: Column(
          children: [


            Expanded(
              child: widget.products.isNotEmpty?Container(
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
                          childAspectRatio: 0.78, // Adjust height-to-width ratio
                        ),
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,

                        itemCount: widget.products.length ?? 0,
                        itemBuilder: (context, index) {
                          Product? item = widget.products[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.productDetailScreen,
                                  arguments: {'product_id':item.id,'product_name':item.productName});
                            },
                            child: Container(
                              height: 230,
                                width: MediaQuery.of(context).size.width * 0.41,
                                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor, //contt.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
                                  border: Border.all(
                                    color: AppColors.greyColor,
                                    width: 1,
                                  ),
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      height: 138,
                                      width: MediaQuery.of(context).size.width * 0.40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                      child: Stack(
                                        children: [
                                          Container(

                                            height: 146, width: 146,
                                            decoration: BoxDecoration(
                                              color: AppColors.containerBorderColor,
                                              borderRadius: BorderRadius.circular(10),
                                              // image: DecorationImage(
                                              //     fit: BoxFit.fill,
                                              //     image: AssetImage(contt.featuredItems[item].images)
                                              //
                                              // )
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedImageCircle2(
                                                imageUrl: item.productImages!.isNotEmpty?'${item.productImages![0]}'
                                                    : ApiUrls.productEmptyImgUrl,
                                                isCircular: false,
                                                // fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),

                                          // Visibility(
                                          //   visible: item.featured??false,
                                          //   child: Align(
                                          //     alignment: Alignment.topRight,
                                          //     child: Container(
                                          //       margin: EdgeInsets.only(top: 5, right: 5),
                                          //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          //       decoration: BoxDecoration(
                                          //         color: AppColors.yellowColor,
                                          //         borderRadius: BorderRadius.circular(20),
                                          //       ),
                                          //       child: addText400("Featured",
                                          //         color: AppColors.blackColor, fontSize: 11, ),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(width: 10,),
                                        addText700("₦${item.price??0}",
                                          color: AppColors.blackColor, fontSize: 12,fontFamily: '' ),
                                        GestureDetector(
                                          onTap: (){
                                            item.favoriteIcon = !item.favoriteIcon!;
                                            setState(() {});
                                            flipzyPrint(message: 'message: ${item.favoriteIcon}');

                                            addToFavApi(productId: item.id).then((value){
                                              if(value.status==true){
                                                showToast('${value.message}');
                                              }
                                            });

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              shape: BoxShape.circle
                                            ),
                                            child: SvgPicture.asset(
                                              AppAssets.isFavouriteSelect,
                                              color: item.favoriteIcon==true?null:AppColors.containerBorderColor1,
                                              fit: BoxFit.contain,
                                              height: 15, width: 15,

                                            ).marginAll(6),
                                          ),
                                        ),
                                        // SizedBox(width: 5/**/,)
                                      ],
                                    ),
                                    //rating
                                    addHeight(2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(width: 10,),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: 80) ,
                                          child: addText500("${item.productName?.capitalize??''}",
                                              color: AppColors.blackColor, fontSize: 10,fontFamily: 'Manrope', maxLines: 1, overflow: TextOverflow.ellipsis ),
                                        ),
                                        /*Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                          decoration: BoxDecoration(
                                            // color: AppColors.yellowColor,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: AppColors.blackColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 10, width: 10,
                                                child: SvgPicture.asset(
                                                  AppAssets.ratingIc,
                                                  fit: BoxFit.contain,

                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child: addText500("${item.rating??0}",
                                                  color: AppColors.blackColor, fontSize: 11, ),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ],
                                )
                            ),
                          );
                        }
                    ),

                  ],
                ),
              ):Center(child: addText600('No Products Found')),
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
  }
}
