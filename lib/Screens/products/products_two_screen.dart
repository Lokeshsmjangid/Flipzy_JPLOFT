import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/controllers/get_product_by_cat_id_controller.dart';

import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Api/api_models/home_model_response.dart';


class ProductsTwoScreen extends StatelessWidget {
  ProductsTwoScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductByCategoryController>(
        // init: ProductByCategoryController(),
        builder: (cntrl) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: customAppBar(
              backgroundColor: AppColors.bgColor,
              leadingWidth: MediaQuery.of(context).size.width * 0.3,
              leadingIcon: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 16,).marginSymmetric(horizontal: 12),
                    addText400("Back", color: AppColors.blackColor,),
                  ],
                ),
              ),
              centerTitle: true,
              titleTxt: "${cntrl.catName} Products",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              actionItems: [
              ],
              bottomLine: true,
            ),
            extendBody: true,
            body : SafeArea(
              child: Column(
                children: [
          //SearchTxtForm
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
                        cntrl.deBounce.run(() {
                          cntrl.page = 1;
                          cntrl.modelResponse.data!.clear();
                          cntrl.fetchCatProductsListData(searchValue: val,pageNumm: 1);
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child:  cntrl.isDataLoading
                        ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                        : cntrl.modelResponse.data!=null && cntrl.modelResponse.data!.isNotEmpty
                        ? Stack(
                          children: [
                            GridView.builder(
                              controller: cntrl.paginationScrollController,
                                physics: BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 1,
                                  childAspectRatio: 0.82, // Adjust height-to-width ratio
                                ),
                                shrinkWrap: true,

                                scrollDirection: Axis.vertical,

                                itemCount: cntrl.modelResponse.data?.length??0,
                                itemBuilder: (context, index) {
                                  Product item = cntrl.modelResponse.data![index];
                                  return GestureDetector(
                                    onTap: (){
                                      if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}else{
                                        Get.toNamed(AppRoutes.productDetailScreen,
                                            arguments: {'product_id':item.id,'product_name':item.productName});
                                      }

                                    },
                                    child: Container(
                                        height: 270,
                                        width: MediaQuery.of(context).size.width * 0.40,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor, //cntrl.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
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
                                              height: 147, width: 147,
                                              decoration: BoxDecoration(
                                                color: AppColors.containerBorderColor,
                                                borderRadius: BorderRadius.circular(10),
                                                // image: DecorationImage(
                                                //     fit: BoxFit.fill,
                                                //     image: AssetImage(cntrl.featuredItems[item].images)
                                                //
                                                // )
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
                                                          imageUrl: item.productImages!.isNotEmpty?'${item.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),

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
                                                    addText700("₦${item.price}",
                                                        color: AppColors.blackColor, fontSize: 14, fontFamily: '').marginOnly(top: 6),

                                                    Container(
                                                      constraints: BoxConstraints(maxWidth: 80) ,
                                                      child: addText500("${item.productName?.capitalize??''}",
                                                          color: AppColors.blackColor,
                                                          fontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis,fontFamily: 'Manrope' ),
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
                            if(cntrl.isPageLoading && cntrl.page != 1)
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
          ),
        ],
      );
    });
  }
}