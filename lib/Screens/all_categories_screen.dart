import 'package:flipzy/controllers/category_controller.dart';
import 'package:flipzy/controllers/homeScreen_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/filter_bottomsheet.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../Api/api_models/category_model.dart';

class AllCategoriesScreen extends StatefulWidget {
  List<Category> categoryList = [];

  AllCategoriesScreen({super.key, required this.categoryList});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final ctrl = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
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
            titleTxt: "All Categories",
            titleColor: AppColors.blackColor,
            titleFontSize: 16,
            bottomLine: true,
          ),
          extendBody: true,
          body: SafeArea(
            child: Column(
              children: [
                // SearchTxtForm
                addHeight(8),
                CustomTextField(
                  borderRadius: 30,
                  // controller: ctrl.searchCtrl,
                  hintText: "Search Category Name",
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
                    ctrl.deBounce.run(() {
                      ctrl.page = 1;
                      ctrl.model.data=[];
                      ctrl.fetchCategories(searchValue: val,pageNumm: 1);
                    });
                  },
                ).marginSymmetric(horizontal: 14),

                Expanded(
                  child: GetBuilder<CategoryController>(
                    init: CategoryController(),
                      builder: (logic) {
                    return logic.isDataLoading
                        // ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor),)
                        ? build_shimmer_loader()
                        : logic.model.data!=null && logic.model.data!.isNotEmpty
                        ? Stack(
                          children: [
                            GridView.builder(

                                controller: ctrl.paginationScrollController,
                                physics: BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // 2 items per row
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.76, // Adjust height-to-width ratio
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,

                                itemCount: logic.model.data!.length,
                                itemBuilder: (context, item) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.productsTwoScreen,
                                          arguments: {
                                            'catID': logic.model.data![item].id,
                                            'catName': logic.model.data![item].name
                                          }); // product based on category

                                    },
                                    child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          //contt.featuredItems[item].isSelect ? AppColors.blackColor : AppColors.whiteColor,
                                          border: Border.all(
                                            color: AppColors.greyColor,
                                            width: 1,
                                          ),
                                          // shape: BoxShape.circle,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [

                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: AppColors.bgColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                height: 60, width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: CachedImageCircle2(
                                                  isCircular: false,
                                                    imageUrl: logic.model.data![item].image),


                                              ),
                                            ),

                                            SizedBox(height: 5,),

                                            addText700(
                                                '${logic.model.data![item].name}',
                                                textAlign: TextAlign.center,
                                                color: AppColors.blackColor,
                                                fontSize: 12,
                                                maxLines: 2),

                                          ],
                                        )
                                    ),
                                  );
                                }
                            ).marginSymmetric(horizontal: 12,vertical: 12),
                            if(ctrl.isPageLoading && ctrl.page != 1)
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
                        : Center(child: addText600('No categories found'));
                  }),
                ),
              ],
            ),
          ),

        ),

      ],
    );
  }

  build_shimmer_loader() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 1,
        childAspectRatio: 0.8,
      ),
      itemCount: 15, // Placeholder count
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
                  height: 60,
                  width: 60,
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
