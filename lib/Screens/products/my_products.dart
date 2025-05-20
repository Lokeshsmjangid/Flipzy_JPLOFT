import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/delete_product_repo.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/controllers/ProductManagementController.dart';
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
import 'package:shimmer/shimmer.dart';

class MyProductsScreen extends StatelessWidget {
  MyProductsScreen({super.key});

  final cont = Get.find<MyProductsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProductsController>(
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
              titleTxt: "My Products",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: true,
            ),

            extendBody: true,
            bottomNavigationBar: AuthData().userModel?.userType?.toLowerCase()=='user'
                ? null
                : SafeArea(
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(
                    color: AppColors.greyColor,
                  ),

                ),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.addProductScreen)?.then((value){
                      contt.onInit();
                    });
                  },
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
                  ).marginSymmetric(horizontal: 8,vertical: 6),
                ),
              ).marginSymmetric(horizontal: 20,vertical: 4),
            ),
            body: SafeArea(
              child: Column(
                children: [

                  //SearchTxtForm

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: CustomTextField(
                      borderRadius: 30,
                      controller: contt.srchCtrl,
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
                          contt.fetchMyProductsListData(searchValue: val);
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    build_product_box(contt,selectedTab: 1,boxName: 'Boosted',onTap: (){
                      contt.selectedTab=1;
                      contt.page=1;
                      contt.srchCtrl.clear();
                      contt.update();
                      contt.fetchMyProductsListData();
                    }),
                    addWidth(10),
                    build_product_box(contt,selectedTab: 2,boxName: 'All Products',onTap: (){
                      contt.selectedTab=2;
                      contt.page=1;
                      contt.srchCtrl.clear();
                      contt.update();
                      contt.fetchMyProductsListData();
                    }),
                  ],),
                  addHeight(6),
                  Expanded(
                    child:  contt.isDataLoading
                        // ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                        ? build_shimmer_loader()
                        : contt.modelResponse.data!=null && contt.modelResponse.data!.listProducts!=null && contt.modelResponse.data!.listProducts!.isNotEmpty
                        ? ListView(
                          shrinkWrap: true,
                          controller: contt.paginationScrollController,
                          physics: BouncingScrollPhysics(),
                          children: [
                            GridView.builder(

                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                itemCount: contt.modelResponse.data!.listProducts?.length??0,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.76, // Adjust height-to-width ratio
                                ),
                                itemBuilder: (context, index) {
                                  Product item = contt.modelResponse.data!.listProducts![index];
                                  return GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoutes.editProductScreen,arguments: {'editProduct': item});
                                    },
                                    child: Container(
                                        height: 270,
                                        width: double.infinity,
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
                                              height: 147, width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: AppColors.containerBorderColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: CachedImageCircle2(
                                                        isCircular: false,fit: BoxFit.cover,
                                                        imageUrl: item.productImages!.isNotEmpty?'${item.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),

                                                  ),

                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 5),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // SizedBox(width: 10,),
                                                Container(
                                                  constraints: BoxConstraints(maxWidth: 80),
                                                  child: addText700("₦${item.price??0}",
                                                    color: AppColors.blackColor, maxLines: 1,fontSize: 14, fontFamily: ''),
                                                ),

                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap : () {
                                                        DeleteProductDialog.show(context,
                                                            onTap1: (){
                                                          showLoader(true);
                                                              deleteProductApi(productId: item.id).then((value){
                                                                showLoader(false);
                                                                if(value.status==true){
                                                                  Get.back();
                                                                  contt.modelResponse.data!.listProducts?.remove(item);
                                                                  contt.update();
                                                                  showToast('${value.message}');
                                                                }
                                                              });



                                                            },
                                                            onTap2: () => Get.back());
                                                      } ,
                                                      child: Container(

                                                        decoration: BoxDecoration(
                                                          color: AppColors.appRedColor,
                                                          shape: BoxShape.circle ,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          AppAssets.deleteIC,
                                                          fit: BoxFit.contain,
                                                          height: 15, width: 15,
                                                        ).marginAll(6),
                                                      ),
                                                    ),
                                                    addWidth(6),
                                                    GestureDetector(
                                                      onTap : () {
                                                        Get.toNamed(AppRoutes.editProductScreen,arguments: {
                                                          'editProduct': item});
                                                      } ,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: AppColors.appGreenColor,
                                                          shape: BoxShape.circle ,
                                                        ),

                                                        child: SvgPicture.asset(
                                                          AppAssets.editPenIc,
                                                          // AppAssets.editPenIc,
                                                          fit: BoxFit.contain,
                                                          height: 15, width: 15,
                                                        ).marginAll(6),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // SizedBox(width: 80,)
                                              ],
                                            ),
                                            addHeight(2),

                                            Container(
                                              constraints: BoxConstraints(maxWidth: 80) ,
                                              child: addText500("${item.productName?.capitalize??''}",
                                                  color: AppColors.blackColor,
                                                  fontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis,fontFamily: 'Manrope' ),
                                            ),

                                          ],
                                        )
                                    ),
                                  );
                                }
                            ).marginSymmetric(horizontal: 12),
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
                        : Center(child: addText500('No Data Found'))
                    ,
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
        childAspectRatio: 0.82, // Adjust height-to-width ratio
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
  build_product_box(MyProductsController contt, {void Function()? onTap,int? selectedTab, String? boxName}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 130,
        decoration: BoxDecoration(
            color: selectedTab==contt.selectedTab?AppColors.armyGreenColor: Colors.white,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: AppColors.containerBorderColor,width: 2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(selectedTab==1?
            AppAssets.boostRocket:selectedTab==2?AppAssets.active:AppAssets.all,height: 20,width: 20,color: selectedTab==contt.selectedTab
                ? AppColors.whiteColor:AppColors.armyGreenColor),
            addWidth(6),
            addText500('$boxName',color: selectedTab==contt.selectedTab
                ? AppColors.whiteColor:AppColors.armyGreenColor,),
            // addText500('$boxCount',color: selectedTab==contt.selectedTab
            //     ? AppColors.whiteColor:AppColors.armyGreenColor,),
          ],
        ),

      ),
    );
  }
}
