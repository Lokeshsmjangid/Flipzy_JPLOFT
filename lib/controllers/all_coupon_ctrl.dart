import 'package:flipzy/Api/api_models/coupon_model.dart';
import 'package:flipzy/Api/repos/all_available_coupons_repo.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCouponCtrl extends GetxController{

  CouponModel model = CouponModel();
  bool isDataLoading = false;
  TextEditingController enterCouponCtrl = TextEditingController();
  Coupon? appliedCoupon;
  dynamic product_price;
  dynamic checkout_price;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(Get.arguments!=null){
      appliedCoupon = Get.arguments['applied_coupon'];
      product_price = Get.arguments['product_price'];
      checkout_price = Get.arguments['checkout_price'];
      if(appliedCoupon!=null){
        appliedCoupons.add(appliedCoupon!);
      }
      Future.microtask((){
        isDataLoading = true;
        update();
        fetchCoupons();
      });

    }



  }
  fetchCoupons() async{
    await getAllCouponsApi(productPrice: product_price).then((value){
      model = value;
      moreOffers.addAll(value.data??[]);

        if(value.data!=null && Get.find<CheckOutController>().isEnterCoupon==false){
          for (var offer in moreOffers) {
            if (offer.promoCode == appliedCoupon?.promoCode) {
              offer.actionText = true;
            }
          }
        }

      isDataLoading = false;
      update();
    });
  }
  List<Coupon> appliedCoupons = [];

  List<Coupon> moreOffers = [
    // Coupon(
    //   label: "10% OFF",
    //   labelColor: Colors.orange,
    //   title: "HSBCFEST",
    //   description: "Save ₹58 on this order using select HSBC Credit Cards!",
    //   extra: "Flat 10% discount up to ₹150 using select HSBC Credit Cards on orders above ₹499",
    //   actionText: false,
    // ),
    // Coupon(
    //   label: "5% OFF",
    //   labelColor: Colors.deepPurple,
    //   title: "AXIS30",
    //   description: "Save ₹30 with Axis Bank Cards",
    //   extra: "Minimum order ₹499. Applicable on credit & debit cards.",
    //   actionText: false,
    // ),
  ];

}

/*

class Coupon {
  final String label;
  final Color labelColor;
  final String title;
  final String description;
  final String extra;
  bool actionText;

  Coupon({
    required this.label,
    required this.labelColor,
    required this.title,
    required this.description,
    required this.extra,
    this.actionText = false,
  });
}*/
