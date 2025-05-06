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

import '../Api/api_models/category_model.dart';

class AllCategoriesScreen extends StatelessWidget {
  List<Category> categoryList = [];

  AllCategoriesScreen({super.key, required this.categoryList});

  final ctrl = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: customAppBar(
            backgroundColor: AppColors.bgColor,
            leadingWidth: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            leadingIcon: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_outlined, color: AppColors.blackColor,
                    size: 16,).marginSymmetric(horizontal: 12),
                  addText400("Back", color: AppColors.blackColor,),
                ],
              ),
            ),
            centerTitle: true,
            titleTxt: "All Categories",
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
                // SearchTxtForm
                addHeight(10),
                CustomTextField(
                  borderRadius: 30,
                  // controller: ctrl.searchCtrl,
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
                    ctrl.deBounce.run(() {
                      ctrl.fetchCategories(searchValue: val);
                    });
                  },
                ).marginSymmetric(horizontal: 14),

                Expanded(
                  child: GetBuilder<CategoryController>(builder: (logic) {
                    return logic.isDataLoading
                        ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor),)
                        : logic.model.data!=null && logic.model.data!.isNotEmpty
                        ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // height: 300,
                      // height: MediaQuery.of(context).size.height * 0.80,/**/

                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          GridView.builder(
                            // gridDelegate: SliverGridDelegate(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // 2 items per row
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 1,

                                childAspectRatio: 0.8, // Adjust height-to-width ratio
                              ),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
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
                                    // width: MediaQuery.of(context).size.width * 0.41,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
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
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              // image: DecorationImage(image: AssetImage(contt.featuredItems[item].images,))
                                            ),
                                            child: Container(

                                              height: 60, width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              child: CachedImageCircle2(
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
                          ),
                        ],
                      ),
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
}
