import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/api_models/wishlist_model_response.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/controllers/ProductManagementController.dart';
import 'package:flipzy/controllers/wishlist_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/delete_product_dialogue.dart';
import 'package:flipzy/dialogues/filter_bottomsheet.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {

  FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(
        builder: (contt) {
          return Scaffold(
            backgroundColor: AppColors.lightGreyColor,

            body: SafeArea(
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
                        contt.deBounce.run(() {
                          contt.fetchWishListData(searchValue: val);
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 300,

                      child: contt.isDataLoading
                          ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                          : contt.modelResponse.wishlist!=null && contt.modelResponse.wishlist!.isNotEmpty
                          ? ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 1,
                                childAspectRatio: 0.78, // Adjust height-to-width ratio
                              ),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: contt.modelResponse.wishlist?.length ?? 0,
                              itemBuilder: (context, index) {
                                Product item = contt.modelResponse.wishlist![index];
                                // Product? itemDetail = item.productDetails;

                                return GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.productDetailScreen,
                                        arguments: {'product_id':item.id,'product_name':item.productName});
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          addHeight(2),
                                          Container(
                                            height: 147, width: 147,
                                            decoration: BoxDecoration(
                                              color: AppColors.containerBorderColor,
                                              borderRadius: BorderRadius.circular(10),
                                              // image: DecorationImage(
                                              //     fit: BoxFit.fill,
                                              //     image: AssetImage(contt.featuredItems[item].images)
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
                                                        imageUrl: item.productImages!.isNotEmpty
                                                            ?'${item.productImages![0]}'
                                                            :'${ApiUrls.productEmptyImgUrl}'),

                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              addText700("₦${item.price}", color: AppColors.blackColor, fontSize: 12, fontFamily: ''),
                                              GestureDetector(
                                                onTap : () {
                                                  item.favoriteIcon = !item.favoriteIcon!;
                                                  contt.update();
                                                  flipzyPrint(message: 'message: ${item..favoriteIcon}');

                                                  addToFavApi(productId: item.id).then((value){
                                                    if(value.status==true){
                                                      showToast('${value.message}');
                                                      contt.modelResponse.wishlist!.remove(item);
                                                      contt.update();
                                                    }
                                                  });

                                                } ,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.appGreenColor,
                                                    shape: BoxShape.circle ,
                                                  ),
                                                  // margin: EdgeInsets.only(right: 5),
                                                  child: SvgPicture.asset(
                                                    AppAssets.isFavouriteSelect,
                                                    // AppAssets.editPenIc,
                                                    color: item.favoriteIcon==true?null:AppColors.containerBorderColor1,
                                                    fit: BoxFit.contain,
                                                    height: 15, width: 15,
                                                  ).marginAll(6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          addHeight(2),
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 80) ,
                                            child: addText400("${item.productName?.capitalize??''}",
                                                color: AppColors.blackColor, fontSize: 10, maxLines: 1,
                                                fontFamily: 'Manrope',overflow: TextOverflow.ellipsis ),
                                          ),

                                        ],
                                      )
                                  ),
                                );
                              }
                          ),

                        ],
                      )
                          : Center(child: addText500('No Data Found')),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
}
