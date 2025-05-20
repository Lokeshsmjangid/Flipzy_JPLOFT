

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/custom_drawer.dart';
import 'package:flipzy/Screens/products/product_detail_screen.dart';
import 'package:flipzy/Screens/products/products_screen.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/dialogues/who_are_you_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/homeScreen_controller.dart';
import '../custom_widgets/customAppBar.dart';
import '../resources/app_color.dart';
import 'all_categories_screen.dart';
import 'product_management.dart';
import 'products/all_products.dart';
import 'products/products_two_screen.dart';
import 'view_all_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
        builder: (contt) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,

        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async{
              contt.onInit();
            },
            child: Column(
              children: [
                addHeight(1.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: CustomTextField(
                    borderRadius: 30,
                    controller: contt.searchCtrl,
                    prefixIcon: SvgPicture.asset(
                      AppAssets.searchBoxesIc,
                      color: AppColors.blackColor,
                      width: 15,
                      height: 15,
                    ),
                    hintText: "Smart Phone I",
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.searchIcon,
                        color: AppColors.blackColor,
                        width: 31,
                        height: 30,
                      ),
                    ),
                    onChanged: (value){
                      contt.deBounce.run(() {
                        if(value.isNotEmpty)
                          if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}else{
                            Get.toNamed(AppRoutes.allProductsScreen,arguments: {'searchTerm': value})?.then((valu){
                              contt.searchCtrl.clear();
                              contt.update();
                            });
                          }

                      });
                    },
                  ),
                ),

                Expanded(
                    child: contt.isDataLoading
                        ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor),)
                        : contt.homeModel.data!=null
                        ? SingleChildScrollView(child: Column(
                    children: [
                      //BrowseCategory
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 16),
                                child: addText700("Browse Categories",
                                  color: AppColors.blackColor, fontSize: 16,fontFamily: 'Manrope')
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.to(AllCategoriesScreen(categoryList: contt.homeModel.data!.categoryList!,));
                                if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                                else { Get.toNamed(AppRoutes.allCategoriesScreen);}
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline, // Adds an underline
                                    fontSize: 12,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //CategoryItems
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 80,
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: contt.homeModel.data!.categoryList!.length ?? 0,
                            itemBuilder: (context, item) {
                              // String? input =  contt.servicesModel.data?[item].title?.replaceAll(" ", "\n") ;
                              return GestureDetector(
                                onTap: () {
                                  // contt.categoryItems.forEach((val) {
                                  //   val.isSelect = false;
                                  // },);
                                  // contt.categoryItems[item].isSelect = !contt.categoryItems[item].isSelect;
                                  // contt.update();
                                  if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                                  else{
                                    Get.toNamed(AppRoutes.productsTwoScreen, arguments: {
                                      'catID':contt.homeModel.data!.categoryList![item].id,
                                      'catName':contt.homeModel.data!.categoryList![item].name}); // product based on category
                                  }
                                },
                                child: Container(
                                  // height: 100,
                                  // width: MediaQuery.of(context).size.width*0.4,
                                  // width: 150,
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    // color: contt.categoryItems[item].isSelect ? AppColors.primaryColor : AppColors.whiteColor,
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: CachedImageCircle2(
                                        imageUrl: '${contt.homeModel.data!.categoryList![item].image}',
                                        fit: BoxFit.cover,
                                        height: 40,width: 40).marginAll(4),
                                    // child: SvgPicture.asset(contt.categoryItems[item].images,
                                    //   color: AppColors.blackColor,),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),

                      //Featured
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(width: 10,),
                            Container(
                                margin: EdgeInsets.only(left: 16),
                                child: addText700("Featured",
                                  color: AppColors.blackColor, fontSize: 16,fontFamily: 'Manrope' )
                            ),
                            GestureDetector(
                              onTap: () {
                                if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                                else{

                                // Get.to(ViewAllHomeScreen(products: contt.homeModel.data?.featuredProducts??[]));
                                  Get.toNamed(AppRoutes.allProductsScreen,arguments: {'searchTerm': ''})?.then((valu){
                                    contt.searchCtrl.clear();
                                    contt.update();
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline, // Adds an underline
                                    fontSize: 12,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //FeaturedItems
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 228,
                        child:contt.homeModel.data!.featuredProducts!.isNotEmpty? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: contt.homeModel.data?.featuredProducts?.length ?? 0,
                            itemBuilder: (context, index) {
                              Product? item = contt.homeModel.data?.featuredProducts?[index];
                              return GestureDetector(
                                onTap : () {
                                  if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                                  else{
                                    Get.toNamed(AppRoutes.productDetailScreen,
                                        arguments: {'product_id':item.id,'product_name':item.productName});
                                  }
                                },
                                child: Container(
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
                                          height: 142,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),

                                          ),
                                          child: Stack(
                                            children: [
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
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedImageCircle2(
                                                    fit: BoxFit.cover,
                                                    imageUrl: item!.productImages!.isNotEmpty?'${item.productImages![0]}':ApiUrls.productEmptyImgUrl,
                                                    isCircular: false,
                                                    // fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                              Visibility(
                                                visible: item.featured??false,
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 5, right: 5),
                                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.yellowColor,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: addText400("Featured",
                                                      color: AppColors.blackColor, fontSize: 11, ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // SizedBox(width: 10,),
                                            Container(
                                              constraints: BoxConstraints(maxWidth: 80),
                                              child: addText700("₦${item.price??0}",maxLines: 1,
                                                color: AppColors.blackColor, fontSize: 12,fontFamily: '' ),
                                            ),
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
                                                  color: AppColors.blackColor, fontSize: 10, maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,fontFamily: 'Manrope' ),
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
                                ).marginOnly(left: index==0 && contt.homeModel.data!.featuredProducts!.length > 1?12:0),
                              );
                            }
                        ) :Center(child: addText500('No Featured Product Found')),
                      ),

                      //Mobile
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(width: 10,),
                            Container(
                                margin: EdgeInsets.only(left: 16),
                                child: addText700("Products",
                                  color: AppColors.blackColor, fontSize: 16,fontFamily: 'Manrope' )
                            ),
                            GestureDetector(
                              onTap: () {
                                if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}else{
                                // Get.to(ViewAllHomeScreen(products: contt.homeModel.data?.productList??[]));
                                  Get.toNamed(AppRoutes.allProductsScreen,arguments: {'searchTerm': ''})?.then((valu){
                                    contt.searchCtrl.clear();
                                    contt.update();
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline, // Adds an underline
                                      fontSize: 12,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //MobileItems
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 228,
                        child:contt.homeModel.data!.productList!.isNotEmpty? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: contt.homeModel.data?.productList?.length ?? 0,
                            itemBuilder: (context, index) {
                              Product? item = contt.homeModel.data?.productList?[index];
                              return GestureDetector(
                                onTap : () {
                                  if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                                  else{
                                    Get.toNamed(AppRoutes.productDetailScreen,
                                        arguments: {'product_id':item.id,'product_name':item.productName});
                                  }

                                },
                                child: Container(
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
                                          height: 142,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),

                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 147, width: 147,
                                                decoration: BoxDecoration(
                                                  color: AppColors.containerBorderColor,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedImageCircle2(
                                                    imageUrl: item!.productImages!.isNotEmpty?'${item.productImages![0]}':ApiUrls.productEmptyImgUrl,
                                                    isCircular: false,
                                                    fit: BoxFit.cover
                                                    // fit: BoxFit.fill,
                                                  ),
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
                                        SizedBox(height: 5,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // SizedBox(width: 10,),
                                            Container(
                                              constraints: BoxConstraints(maxWidth: 80),
                                              child: addText700("₦${item.price??0}",maxLines: 1,
                                                color: AppColors.blackColor, fontSize: 12, fontFamily: ''),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                item.favoriteIcon = !item.favoriteIcon!;
                                                setState(() {});
                                                flipzyPrint(message: 'message: ${item.favoriteIcon}');

                                                addToFavApi(productId: item.id).then((value){
                                                  if(value.status==true){showToast('${value.message}');}});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
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
                                              child: addText400("${item.productName?.capitalize??''}",
                                                  color: AppColors.blackColor, fontSize: 10, maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,fontFamily: 'Manrope' ),
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
                                ).marginOnly(left: index==0 && contt.homeModel.data!.productList!.length > 1?12:0),
                              );
                            }
                        )
                              : Center(child: addText500('No Product Found')),
                      ),

                      // SizedBox(height: 110,),
                    ],
                  ))
                        : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: addText500('No Data Found')),
                            /*addHeight(4),
                            Center(child: GestureDetector(
                              onTap: (){
                                showLoader(true);
                                contt.fetchHomeData();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.redColor,
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: addText500('Refresh',color: AppColors.whiteColor).marginSymmetric(horizontal: 10,vertical: 2)),
                            )),*/
                          ],
                        )
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
