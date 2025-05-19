import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/Api/repos/delete_product_repo.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/controllers/ProductManagementController.dart';
import 'package:flipzy/controllers/all_products_controller.dart';
import 'package:flipzy/controllers/my_products_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/dialogues/filter_bottomsheet.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class AllProductsScreen extends StatefulWidget {
  AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductsController>(
        init: AllProductsController(),
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
              titleTxt: "Search Products",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: true,
            ),
            extendBody: true,
            /*bottomNavigationBar: SafeArea(
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(
                    color: AppColors.greyColor,
                  ),

                ),
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
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
                  ).marginSymmetric(horizontal: 8,vertical: 6),
                ),
              ).marginSymmetric(horizontal: 20,vertical: 4),
            ),*/
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            borderRadius: 30,
                            controller: contt.searchController,
                            hintText: "Search Product Name",
                            fillColor: AppColors.whiteColor,
                            suffixIcon: Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 2, bottom: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
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
                            onChanged: (val) {
                              contt.deBounce.run(() {
                                contt.page = 1;
                                contt.modelResponse.myProducts?.clear();
                                contt.fetchMyProductsListData(
                                    searchValue: val, pageNumm: 1,ISFILTER: false);
                              });
                            },
                          ),
                        ),
                        addWidth(12),
                        GestureDetector(
                          onTap: (){
                            FilterBottomsheet.show(context,
                                onTap1: (){
                              Get.back();
                              contt.modelResponse.myProducts?.clear();
                              String? sortBy  = contt.shortList.firstWhereOrNull((item) => item.isSelect?.value == true)?.shortValSend?.value;
                              String? pd  = contt.productConditionList.firstWhereOrNull((item) => item.isSelect?.value == true)?.conditionVal?.value;


                                  contt.fetchMyProductsListData(
                                      pageNumm: 1,
                                      ISFILTER: true,
                                      PRICE: "${contt.currentRangeValues.value.start.round()}-${contt.currentRangeValues.value.end.round()}",
                                    SORT: sortBy,
                                    PD: pd
                                  );
                                },
                                onTap2: (){
                              contt.filterLocation.clear();
                              for (var item in contt.shortList) {
                                item.isSelect?.value = false;
                              }
                              for (var item in contt.productConditionList) {
                                item.isSelect?.value = false;
                              }
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: SvgPicture.asset(AppAssets.filterIc,color: AppColors.blackColor,).marginAll(6)),
                        )
]
                    ),
                  ),

                  Expanded(
                    child: contt.isDataLoading
                        // ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                        ? build_shimmer_loader()
                        : contt.modelResponse.myProducts != null && contt.modelResponse.myProducts!.isNotEmpty
                            ? Stack(
                              children: [
                                GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 items per row
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 1,
                                      childAspectRatio:
                                          0.78, // Adjust height-to-width ratio
                                    ),
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    controller: contt.paginationScrollController,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        contt.modelResponse.myProducts?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      Product item =
                                          contt.modelResponse.myProducts![index];
                                      return GestureDetector(
                                        onTap: () {
                                          if (AuthData().userModel?.guestId !=
                                              null) {
                                            Get.toNamed(AppRoutes.loginScreen);
                                          } else {
                                            Get.toNamed(
                                                AppRoutes.productDetailScreen,
                                                arguments: {'product_id': item.id});
                                          }
                                        },
                                        child: Container(
                                            height: 270,
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                addHeight(4),
                                                Container(
                                                  height: 147,
                                                  width: 147,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.containerBorderColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: SizedBox(
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                          child: CachedImageCircle2(
                                                              isCircular: false,
                                                              fit: BoxFit.cover,
                                                              imageUrl: item.productImages!.isNotEmpty
                                                                  ? '${item.productImages![0]}'
                                                                  : '${ApiUrls.productEmptyImgUrl}'),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: item.bestseller??false,
                                                        child: Align(
                                                          alignment: Alignment.topRight,
                                                          child: Container(
                                                            margin: EdgeInsets.only(top: 5, right: 5),
                                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                            decoration: BoxDecoration(
                                                              color: AppColors.yellowColor,
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                            child: addText400("Best Seller",
                                                              color: AppColors.blackColor, fontSize: 11, ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    addText700("₦${item.price}",
                                                        color: AppColors.blackColor,
                                                        fontSize: 12,
                                                        fontFamily: ''),
                                                    GestureDetector(
                                                      onTap: () {
                                                        item.favoriteIcon =
                                                            !item.favoriteIcon!;
                                                        setState(() {});
                                                        flipzyPrint(
                                                            message:
                                                                'message: ${item.favoriteIcon}');

                                                        addToFavApi(
                                                                productId: item.id)
                                                            .then((value) {
                                                          if (value.status ==
                                                              true) {
                                                            showToast(
                                                                '${value.message}');
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        child: SvgPicture.asset(
                                                          AppAssets
                                                              .isFavouriteSelect,
                                                          color: item.favoriteIcon ==
                                                                  true
                                                              ? null
                                                              : AppColors
                                                                  .containerBorderColor1,
                                                          fit: BoxFit.contain,
                                                          height: 15,
                                                          width: 15,
                                                        ).marginAll(6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  constraints:
                                                      BoxConstraints(maxWidth: 80),
                                                  child: addText500(
                                                      "${item.productName?.capitalize ?? ''}",
                                                      color: AppColors.blackColor,
                                                      fontSize: 10,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontFamily: 'Manrope'),
                                                ),
                                              ],
                                            )),
                                      );
                                    }),
                                if(contt.isPageLoading && contt.page != 1)
                                  Positioned(
                                    bottom:10,
                                    left: 0,right: 0,
                                    child: Container(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 16,
                                              width: 16,

                                              child: CircularProgressIndicator(color: AppColors.whiteColor,strokeWidth: 1)),
                                          addWidth(10),
                                          addText400('Loading...',color: AppColors.whiteColor)
                                        ],
                                      ).marginSymmetric(horizontal: 10,vertical: 4),
                                    ),
                                  )
                              ],
                            )
                            : Center(child: addText500('No Data Found')),
                  ),
                ],
              ),
            ),
          );
        });
  }
  build_shimmer_loader() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 2,
        mainAxisSpacing: 1,
        childAspectRatio:
        0.78, // Adjust height-to-width ratio
      ),
      shrinkWrap: true,
      itemCount: 12, // Placeholder count
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 147, width: 147,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 10,
                  width: 60,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5),
                Container(
                  height: 10,
                  width: 40,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
