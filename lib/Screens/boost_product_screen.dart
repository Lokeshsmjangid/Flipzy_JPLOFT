import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/boost_plans_model.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/boost_plans_repo.dart';
import 'package:flipzy/Api/repos/make_product_boost_repo.dart';
import 'package:flipzy/Api/repos/verify_payment_repo.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/custom_widgets/custom_dropdown.dart';
import 'package:flipzy/dialogues/boost_product_dialogue.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostProductScreen extends StatefulWidget {
  Product? makeBoostProduct;
  BoostProductScreen({super.key, this.makeBoostProduct});

  @override
  State<BoostProductScreen> createState() => _BoostProductScreenState();
}

class _BoostProductScreenState extends State<BoostProductScreen> {
  TextEditingController pricePlane = TextEditingController();

  // Map<String,dynamic>? selectedPlan;
  // List<Map<String,dynamic>> boostPlans = [
  //   {'plane':'15-day boosts', 'price':1800},
  //   {'plane':'18-day boosts', 'price':2000},
  //   {'plane':'20-day boosts', 'price':2500},
  //   {'plane':'30-day boosts', 'price':3000},
  // ];

  BoostPlans? selectedPlanApi;
  List<BoostPlans> boostPlansList = [];
  BoostPlansModel model = BoostPlansModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boostPlansApi().then((value) {
      Future.microtask(() {
        setState(() {
          model = value;
          if (value.data != null && value.data!.isNotEmpty) {
            boostPlansList.addAll(value.data!);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Column(
        children: [
          addHeight(44),
          backAppBar(
              onTapBack: () {
                Get.back();
              },
              title: 'Boost Project'),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                addHeight(14),
                SizedBox(
                    height: 200,
                    child: BorderedContainer(
                        isBorder: false,
                        padding: 0,
                        child: Center(
                            // child: Image.asset('assets/png_images/orderMangeIphone.png',fit: BoxFit.cover).marginOnly(top: 10)
                            child: CachedImageCircle2(
                                    isCircular: false,
                                    imageUrl: widget.makeBoostProduct!
                                            .productImages!.isNotEmpty
                                        ? '${widget.makeBoostProduct!.productImages![0]}'
                                        : '${ApiUrls.productEmptyImgUrl}',
                                    fit: BoxFit.fill)
                                .marginOnly(top: 10)))),
                addHeight(20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: addText700('₦${widget.makeBoostProduct?.price}',
                        fontFamily: '',
                        color: AppColors.blackColor,
                        fontSize: 24)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: addText700(
                        '${widget.makeBoostProduct?.productName?.capitalize}',
                        fontFamily: 'Manrope',
                        color: AppColors.textColor3,
                        fontSize: 18)),
                addHeight(20),
                BorderedContainer(
                    padding: 20,
                    isBorder: false,
                    bGColor: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addHeight(10),
                        addText700('Details',
                            fontFamily: 'Manrope',
                            color: AppColors.blackColor,
                            fontSize: 16),
                        addHeight(12),
                        build_tile(
                            title: 'Brand',
                            subTitle:
                                '${widget.makeBoostProduct?.brandName?.capitalize}',
                            subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        build_tile(
                            title: 'Category',
                            subTitle:
                                '${widget.makeBoostProduct?.category?.capitalize ?? ''}',
                            subTitleColor: AppColors.blackColor),

                        addHeight(12),
                        // build_tile(title: 'Description',subTitle: '${widget.makeBoostProduct?.productDescription} skjhfj eihfiuewf jjehdiuehwf iedhew',subTitleColor: AppColors.blackColor),
                        addText500('Description',
                            fontFamily: 'Manrope',
                            color: AppColors.textColor3,
                            fontSize: 14),
                        Container(
                            constraints: BoxConstraints(maxWidth: 260),
                            child: addText500(
                                '${widget.makeBoostProduct?.productDescription?.capitalizeFirst}',
                                fontFamily: 'Manrope',
                                color: AppColors.blackColor,
                                fontSize: 14)),
                        //
                        // addHeight(12),
                        // build_tile(title: 'Network Type',subTitle: '5G, 4G VOLTE, 4G, 3G, 2G',subTitleColor: AppColors.blackColor),

                        addHeight(4),
                      ],
                    )),
                addHeight(16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: addText400('Choose a Boost Plan',
                      fontFamily: 'Manrope',
                      color: AppColors.blackColor,
                      fontSize: 14),
                ),
                addHeight(6),
                CustomDropdownButton2(
                  hintText: "Choose Boost Plan",
                  items: boostPlansList,
                  value: selectedPlanApi,
                  displayText: (item) =>
                      "${item.plan} (${item.durationInDays}Days)",
                  onChanged: (value) {
                    selectedPlanApi = value;
                    setState(() {
                      pricePlane.text = '${selectedPlanApi?.price}';
                    });
                  },
                  borderRadius: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: addText400('Price',
                      fontFamily: 'Manrope',
                      color: AppColors.blackColor,
                      fontSize: 14),
                ),
                addHeight(6),
                CustomTextField(
                    controller: pricePlane,
                    readOnly: true,
                    fillColor: AppColors.blueColor.withOpacity(0.1),
                    hintText: 'Price according to selected plan'),
                addHeight(16),
                AppButton(
                  buttonText: 'Boost',
                  buttonTxtColor: AppColors.blackColor,
                  isPrefixIcon: true,
                  onButtonTap: () {
                    if (selectedPlanApi != null) {
                      showLoader(true);
                      makeBoostProductApi(
                              productId: widget.makeBoostProduct!.id,
                              boostPrice: pricePlane.text,
                              boostTime: selectedPlanApi?.durationInDays)
                          .then((value) {
                        showLoader(false);
                        if (value.status == true) {
                          Get.toNamed(AppRoutes.paymentWebView, arguments: {
                            'initial_url': value.paymentLink ?? '',
                            'product_id': ''
                          })?.then((value1) {
                            log('call back result ${value1}');
                            if (value1 != null) {
                              showLoader(true);
                              verifyPaymentApi(
                                      isBoost: true,
                                      productId: widget.makeBoostProduct!.id,
                                      tx_ref: value.tx_ref)
                                  .then((val) {
                                showLoader(false);
                                if (val.success == true) {
                                  BoostProductDialog.show(
                                      context,
                                      onTap: () {
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                        Get.toNamed(AppRoutes.allBoostProduct, arguments: {'selectedBox': 1});

                                  });}});};});

                          /*BoostProductDialog.show(context,onTap: (){
                          Get.back();
                          Get.back();
                          Get.back();
                          Get.toNamed(AppRoutes.allBoostProduct,arguments: {'selectedBox':1});
                          // Get.to(SellerProfileScreen());
                        });*/
                        }
                        ;
                      });
                    } else {
                      showToastError('Please Select plan');
                    }
                  },
                ),
                addHeight(24)
              ],
            ).marginSymmetric(horizontal: 16),
          ))
        ],
      ),
    );
  }

  continueButton({void Function()? onTap, Widget? child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        // constraints: const BoxConstraints(maxHeight: 36),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(100)),
        child: child,
      ),
    );
  }

  build_tile(
      {String? title,
      String? subTitle,
      Color subTitleColor = AppColors.greenColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addText500('$title',
            fontFamily: 'Manrope', color: AppColors.textColor3, fontSize: 14),
        Container(
            constraints: BoxConstraints(maxWidth: 260),
            child: addText500('$subTitle',
                fontFamily: 'Manrope', color: subTitleColor, fontSize: 14))
      ],
    );
  }
}
