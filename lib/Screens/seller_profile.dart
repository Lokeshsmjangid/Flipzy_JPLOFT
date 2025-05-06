import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/seller_product_model.dart';
import 'package:flipzy/Api/repos/add_to_fav_repo.dart';
import 'package:flipzy/Api/repos/seller_product_repo.dart';
import 'package:flipzy/Screens/cart_screen.dart';
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

import '../Api/api_models/home_model_response.dart';

class SellerProfileScreen extends StatefulWidget {
  String? sellerId;
  String? sellerName;
  SellerProfileScreen({super.key,this.sellerId,this.sellerName});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  SellerProductsModelResponse model = SellerProductsModelResponse();
  bool isDaTaLoading = false;


  // seller detail
  String? sellerImg;
  String? sellerRating;
  String? sellerLocation;
  String? totalProduct;
  List<Product> products = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      if(widget.sellerId !=null && widget.sellerId!.isNotEmpty){
        fetchData();
      }
    });
  }

  fetchData() async{

    isDaTaLoading = true;
    setState(() {});
    await getSellerProductsApi(sellerID: widget.sellerId).then((value){
      model = value;

      if(model.data!=null){

        sellerImg = model.data!.sellerProfileImage;
        sellerRating = '${model.data!.sellerRating??0}';

        print('object ${model.data!.sellerRating}');
        sellerLocation = model.data!.sellerLocation??'';
        totalProduct = '${model.data!.totalProducts??0}';
      }

      if(value.data!.listProducts!=null && value.data!.listProducts!.isNotEmpty){
        products.addAll(value.data!.listProducts!);
      }
      isDaTaLoading = false;

      setState(() {
      });



    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,),
              addText400("Back", color: AppColors.blackColor),
            ],
          ),
        ),
        centerTitle: true,
        titleTxt: "${widget.sellerName?.capitalize}",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // addHeight(20),

            Expanded(child:
            isDaTaLoading? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor),):
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // addHeight(20),
                  //
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.more_vert)),
                  addHeight(20),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // height: Get.height * 0.22,
                        width: Get.width ,
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: 55,),
                        // padding: EdgeInsets.symmetric(vertical: 40),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          // margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            // color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.greyColor, width: 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.starImage),
                                      addWidth(4),
                                      addText700("${sellerRating}",fontFamily: 'Manrope',fontSize: 14),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Ratings",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/locationic2.svg'),
                                      addWidth(4),
                                      Container(
                                          constraints: BoxConstraints(maxWidth: 100),
                                          child: addText700("${sellerLocation}",
                                              textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Manrope',fontSize: 14)),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Location",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.drawerOT),
                                      addWidth(4),
                                      addText700("${totalProduct}",fontFamily: 'Manrope',fontSize: 14),
                                      // Image.asset(AppAssets.starImage),
                                    ],
                                  ),
                                  addText700("Order Served",fontSize: 12,fontFamily: 'Manrope'),
                                ],
                              ),
                            ],
                          ).marginOnly(top: 50),
                        ),
                      ),

                      Positioned(
                        // top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Color(0xffD0E1EA),
                                // borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.circle
                            ),
                            child: CachedImageCircle2(imageUrl: '$sellerImg')
                            // child: Image.asset(AppAssets.notificationProfileIC,fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),

                  addHeight(20),

        // Withdrawal History
                  ...List.generate(products.length??0, (index){
                    return build_text_tile(item: products[index],title: '₦${products[index].price}',onTap: (){
                      // Get.back();
                      // // Get.back();
                      // Get.toNamed(AppRoutes.productDetailScreen,
                      //     arguments: {'product_id':products[index].id,'product_name':products[index].productName});
                    });
                  })
                ],
              ).marginSymmetric(horizontal: 20),
            ))

          ],
        ),
      ),
    );
  }

  build_text_tile({ Product? item,String? title,bool upperBorder = false,bool lowerBorder = false,void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: AppColors.appBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.containerBorderColor),

        ),
        child: Column(
          children: [
            Row(
              children: [

                // Divider(height: 0,),
                Container(
                    height: 96,
                    width: 126,
                    decoration: BoxDecoration(
                        color: Color(0xffD0E1EA),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedImageCircle2(
                          isCircular: false,
                          imageUrl: item!.productImages!.isNotEmpty?'${item.productImages![0]}':ApiUrls.productEmptyImgUrl,
                          fit: BoxFit.fill),
                      // child: Image.asset(AppAssets.homeScreenIphone2, fit: BoxFit.fill,),
                      // child: Image.network(AppAssets.demoIphoneImageUrl, fit: BoxFit.cover,),
                    ),
                    // child: Image.asset(AppAssets.profileImage,fit: BoxFit.cover,)
                ),
                addWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addText700('${title}',fontSize: 14,fontFamily: '',color: AppColors.blackColor),

                        // Container(
                        //     // constraints: BoxConstraints(
                        //     //     minWidth: 106,
                        //     //     maxWidth: double.infinity,
                        //     // ),
                        //     child: addText500('${title}',fontSize: 16,fontFamily: 'Poppins',color: AppColors.blackColor)),
                        addWidth(Get.width*0.2),
                        // SvgPicture.asset(AppAssets.greenFavourite, color: AppColors.primaryColor, height: 13,width: 13),
                        GestureDetector(
                          onTap: (){
                            item?.favoriteIcon = !item.favoriteIcon!;
                            setState(() {});
                            flipzyPrint(message: 'message: ${item?.favoriteIcon}');

                            addToFavApi(productId: item?.id).then((value){
                              if(value.status==true){showToast('${value.message}');}});
                          },
                          child: SvgPicture.asset(
                            AppAssets.greenFavourite,
                            color: item.favoriteIcon==true?null:AppColors.containerBorderColor1,
                            fit: BoxFit.contain,
                              height: 13,width: 13
                          ),
                        ),

                      ],
                    ),
                    addText500('${item.productName?.capitalize??''} ',fontSize: 10,fontFamily:'Manrope',color: AppColors.textColor2).marginOnly(bottom: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icon/locationic2.svg',height: 12,width: 12,color: AppColors.blackColor,).marginOnly(right: 4),
                        Container(
                          // color: Colors.green,
                            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width*0.4),
                            child: addText500('${sellerLocation}',fontSize: 10,fontFamily:'Manrope',color: AppColors.blackColor))
                      ],
                    ).marginOnly(bottom: 8),


                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.blackColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(item.rating!=null)
                              SvgPicture.asset(AppAssets.starImage),
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('${item.rating==null?'Not Rated Yet':item.rating}',fontSize: 10,fontFamily: 'Manrope',color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 8,vertical: 2),
                        ),
                        // Spacer(),
                        /*addWidth(Get.width*0.1),


                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.primaryColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('View',fontSize: 10,fontFamily: 'Manrope',color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 16,vertical: 2),
                        ),*/

                      ],
                    )
                  ],
                ),


              ],
            ),
          ],
        ),
      ).marginOnly(bottom: 12),
    );

  }
}
