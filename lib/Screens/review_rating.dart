import 'package:flipzy/controllers/rating_review_controller.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReviewsRatingScreen extends StatefulWidget {
  const ReviewsRatingScreen({super.key});

  @override
  State<ReviewsRatingScreen> createState() => _ReviewsRatingScreenState();
}

class _ReviewsRatingScreenState extends State<ReviewsRatingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            addHeight(20),
            backAppBar(onTapBack: () {
              Get.back();
            }, title: 'Reviews and Ratings'),
            // addHeight(20),

            Expanded(child: GetBuilder<RatingReviewsController>(builder: (logic) {
              return
                logic.isDataLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                    : logic.reviewsResponse.data!=null
                    ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(20),
                    Container(

                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.containerBorderColor),
                          borderRadius: BorderRadius.circular(26)
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addHeight(10),

                                    addText500('Total Rating', fontSize: 18,
                                        fontFamily: 'Manrope',
                                        color: AppColors.blackColor),
                                    addHeight(8),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.starImage,
                                          fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                        ).marginOnly(right: 4),
                                        // Image.asset(AppAssets.starImage,height: 14,width: 14).marginOnly(right: 4),
                                        addText500('${logic.reviewsResponse.data!.totalRatings}', fontSize: 16,
                                            fontFamily: 'Manrope',
                                            color: AppColors.blackColor),
                                      ],
                                    ),
                                    addHeight(10),

                                  ],
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColors.containerBorderColor,
                              indent: 0,
                              endIndent: 0.0,
                              thickness: 1,),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addHeight(10),
                                    addText500(
                                        'Total Reviews', fontFamily: 'Manrope',
                                        fontSize: 18,
                                        color: AppColors.blackColor),
                                    addHeight(8),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.reviewIcon,
                                          fit: BoxFit
                                              .contain, // Try 'contain' or 'fitWidth' if needed
                                        ).marginOnly(right: 4),
                                        // Image.asset(AppAssets.reviewIcon,height: 22,width: 22).marginOnly(right: 4),
                                        addText500('${logic.reviewsResponse.data!.totalReview}', fontSize: 16,
                                            fontFamily: 'Manrope',
                                            color: AppColors.blackColor),
                                      ],
                                    ),
                                    addHeight(10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    // Withdrawal History
                    addHeight(16),
                    addText500('All Reviews', fontSize: 16, fontFamily: 'Poppins', color: AppColors.blackColor).marginOnly(bottom: 8),
                    ...List.generate(
                        logic.reviewsResponse.data!.allReview!.length??0, (index) {
                      return build_text_tile(
                        img: '${logic.reviewsResponse.data!.allReview![index].userId!.profileImage}',
                          title: '${logic.reviewsResponse.data!.allReview![index].userName??''}',
                          review: '${logic.reviewsResponse.data!.allReview![index].userDescription??''}',
                          userRating: '${logic.reviewsResponse.data!.allReview![index].userRating??''}',
                          onTap: () {
                        // Get.toNamed(AppRoutes.sellerProfileScreen);
                      });
                    })
                  ],
                ).marginSymmetric(horizontal: 20),
              )
                    : Center(child: addText500('No Data Found'));
            }))


          ],
        ),
      ),
    );
  }

  build_text_tile(
      { String? title,String? img,String? review, bool upperBorder = false, bool lowerBorder = false, void Function()? onTap,dynamic userRating}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.appBgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              children: [

                // Divider(height: 0,),
                Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Color(0xffD0E1EA),
                        shape: BoxShape.circle
                    ),
                    // child: Image.asset(AppAssets.profileImage)
                    child: CachedImageCircle2(imageUrl: img)
                ),
                addWidth(10),
                addText500(title!.capitalize.toString(), fontSize: 16,
                    fontFamily: 'Poppins',
                    color: AppColors.blackColor),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.starImage,
                        fit: BoxFit
                            .contain, // Try 'contain' or 'fitWidth' if needed
                      ),
                      // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                      addText400('${userRating}', fontSize: 11,
                          fontFamily: 'Poppins',
                          color: AppColors.blackColor),
                    ],
                  ).marginSymmetric(horizontal: 12, vertical: 2),
                )
              ],
            ),
            addHeight(8),
            Align(
              alignment: Alignment.centerLeft,
              child: addText500(
                  '${review}',
                  fontSize: 13,
                  fontFamily: 'Manrope',
                  color: AppColors.blackColor),
            )
          ],
        ),
      ).marginOnly(bottom: 12),
    );
  }
}
