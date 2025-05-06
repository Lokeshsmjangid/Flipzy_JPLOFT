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

class MyProductsScreen extends StatelessWidget {
  MyProductsScreen({super.key});

  final cont = Get.find<MyProductsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProductsController>(
        builder: (contt) {
          return Scaffold(
            backgroundColor: AppColors.lightGreyColor,
            appBar:customAppBar(
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
              titleTxt: "My Products",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: true,
            ),
            extendBody: true,
            bottomNavigationBar: AuthData().userModel?.userType?.toLowerCase()=='user'? null
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

                  Expanded(
                    child:  contt.isDataLoading
                        ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                        : contt.modelResponse.data!=null && contt.modelResponse.data!.listProducts!=null && contt.modelResponse.data!.listProducts!.isNotEmpty
                        ? Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 300,
                      // height: MediaQuery.of(context).size.height * 0.80,/**/

                      child: RefreshIndicator(
                        onRefresh: () async{
                          contt.onInit();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 1,
                                  childAspectRatio: 0.75, // Adjust height-to-width ratio
                                ),
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,

                                itemCount: contt.modelResponse.data!.listProducts?.length??0,
                                itemBuilder: (context, index) {
                                  Product item = contt.modelResponse.data!.listProducts![index];
                                  return Container(
                                      height: 270,
                                      width: MediaQuery.of(context).size.width * 0.40,
                                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                                        imageUrl: item.productImages!.isNotEmpty?'${item.productImages![0]}':'${ApiUrls.productEmptyImgUrl}'),

                                                  ),
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
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
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
}
