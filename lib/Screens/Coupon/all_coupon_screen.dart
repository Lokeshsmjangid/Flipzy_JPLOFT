import 'package:flipzy/Api/api_models/coupon_model.dart';
import 'package:flipzy/Api/repos/apply_coupons_repo.dart';
import 'package:flipzy/controllers/all_coupon_ctrl.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/dialogues/apply_coupon_success_dialogue.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.bgColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: IconButton(
            onPressed: (){
              Get.back(result: Get.find<AllCouponCtrl>().appliedCoupons.isNotEmpty?Get.find<AllCouponCtrl>().appliedCoupons:[]);
              },
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "Apply Coupon",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<AllCouponCtrl>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addText500("Your Checkout: ₦${logic.checkout_price}",fontFamily: ''),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.enterCouponCtrl,
                  decoration: InputDecoration(
                    hintText: "Enter Coupon Code",
                    suffixIcon: ElevatedButton(
                      onPressed: () {
                        showLoader(true);
                        applyCouponApi(promoCode: logic.enterCouponCtrl.text.trim()).then((valu){
                          showLoader(false);
                          if(valu.success==true){
                            Get.find<CheckOutController>().isEnterCoupon =true;
                            logic.appliedCoupons.clear();
                            logic.appliedCoupons.add(valu.data!);
                            logic.update();
                            Get.back(result: Get.find<AllCouponCtrl>().appliedCoupons.isNotEmpty?Get.find<AllCouponCtrl>().appliedCoupons:[]);
                            ApplyCouponSuccessDialog.show(context, logic.appliedCoupons[0]);
                          } else if(valu.success==false){
                            showToastError('${valu.message}');
                          };
                        });




                      },
                      child: const Text("APPLY"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                addHeight(16),
                if(logic.appliedCoupons.isNotEmpty && Get.find<CheckOutController>().isEnterCoupon==false)
                addText700("Applied coupon",).marginOnly(bottom: 10),

                if(Get.find<CheckOutController>().isEnterCoupon==false)
                ...List.generate(

                    logic.appliedCoupons.length, (index){
                  Coupon applyCoupon = logic.appliedCoupons[index];
                  return couponCard(
                      label: "${applyCoupon.discount} ${applyCoupon.discountType}", // discount + discountType
                      labelColor: Colors.orange,
                      title: "${applyCoupon.promoCode}", // promoCode
                      description: "${applyCoupon.shortDescription}", // shortDescription
                      extra: "",// ${applyCoupon.extra}
                      actionText: applyCoupon.actionText==true?"REMOVE":"APPLY",
                    actionTextOnTap: (){
                      if(applyCoupon.actionText==true){
                        for (var coupon in logic.appliedCoupons) {
                          coupon.actionText = true;
                        }
                        applyCoupon.actionText=false;
                      logic.appliedCoupons.clear();
                      logic.update();
                      } else if(applyCoupon.actionText==false){
                        for (var coupon in logic.appliedCoupons) {
                          coupon.actionText = false;
                        }
                        applyCoupon.actionText=true;
                        logic.appliedCoupons.clear();
                        logic.appliedCoupons.add(applyCoupon);
                        logic.update();
                      }
                    }
                  );
                }),
                const SizedBox(height: 20),
                addText700("More offers").marginOnly(bottom: 10),

                ...List.generate(logic.moreOffers.length, (index){
                  Coupon moreCoupon = logic.moreOffers[index];

                  return couponCard(
                      label: "${moreCoupon.discount} ${moreCoupon.discountType}",
                    labelColor: Colors.orange,
                    title: "${moreCoupon.promoCode}",
                    description: "${moreCoupon.title}",
                    extra: "${moreCoupon.shortDescription}", // ${moreCoupon.extra}
                    actionText: moreCoupon.actionText==true?"REMOVE":"APPLY",
                      actionTextOnTap: (){
                      if(moreCoupon.actionText==true){
                        moreCoupon.actionText=false;
                        Get.find<CheckOutController>().isEnterCoupon=false;
                        logic.appliedCoupons.clear();
                        logic.update();
                      } else if(moreCoupon.actionText==false){
                        for (var coupon in logic.moreOffers) {
                          coupon.actionText = false;
                        }
                        moreCoupon.actionText=true;
                        Get.find<CheckOutController>().isEnterCoupon=false;
                        logic.appliedCoupons.clear();
                        logic.appliedCoupons.add(moreCoupon);
                        logic.update();
                        Future.delayed(Duration(microseconds: 200),
                                (){
                          Get.back(result: Get.find<AllCouponCtrl>().appliedCoupons.isNotEmpty?Get.find<AllCouponCtrl>().appliedCoupons:[]);
                          ApplyCouponSuccessDialog.show(context, logic.appliedCoupons[0]);
                        });
                      }
                      }
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget couponCard({
    required String label,
    required Color labelColor,
    required String title,
    required String description,
    required String extra,
    required String actionText,
    void Function()? actionTextOnTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: labelColor,
            child: RotatedBox(
              quarterTurns: 3,
              child: addText700(
                  label, color: AppColors.whiteColor
              ).marginSymmetric(horizontal: 8),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addText700(title, fontSize: 14),
                  GestureDetector(
                    onTap:actionTextOnTap,
                    child: addText700(
                      actionText,color: actionText == 'REMOVE' ? Colors.red : Colors
                        .orange,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addText400(
                      description, color: Colors.green,fontSize: 14),
                  addHeight( 4),

                  addText400(extra,fontSize: 13),
                  addHeight( 4),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}