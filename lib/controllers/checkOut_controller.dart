
import 'package:flipzy/Api/api_models/checkout_detail_model.dart';
import 'package:flipzy/Api/api_models/coupon_model.dart';

import 'package:flipzy/Api/repos/checkout_details_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/api_models/home_model_response.dart';

class CheckOutController extends GetxController{
  CheckOutDetailModel response = CheckOutDetailModel();
  final deBounce = Debouncer(milliseconds: 1000);
  bool isDataLoading = false;

  String shippingAddress = '';
  String city = '';
  String state = '';
  String country = '';
  String postalCode = '';
  double latitude = 0.0;
  double longitude = 0.0;

  Product? productList;
  Coupon? appliedCoupon;
  bool isEnterCoupon = false;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      productList = Get.arguments['product_detail'];
      counter = Get.arguments['quantity'];
      Future.microtask((){
        isDataLoading = true;
        update();
        fetchCheckoutData();
      });
      // getTotalAmount(productPrice: productList?.price??'0',discount: productList?.discount??0,deliveryCharge: productList?.deliveryCharge??0);
    }

    if(shippingAddress.isEmpty){
      shippingAddress = AuthData().userModel?.location??'';
    }

  }

  fetchCheckoutData() async{
    await checkOutDetailApi(qty: counter,productId: productList?.id,promoCode: appliedCoupon?.promoCode).then((val){
      response = val;
      isDataLoading = false;
      /*if(val.data!=null && isEnterCoupon==true){
        appliedCoupon?.promoCode = val.data?.appliedCoupon?.promoCode;
        appliedCoupon?.discount = val.data?.appliedCoupon?.discountValue;
        appliedCoupon?.discountType = val.data?.appliedCoupon?.discountType;
      }*/
      update();
    });
  }

  double? placedAmount = 0.0;
  double? getTotalAmount({String productPrice='0',int discount=0,int deliveryCharge=0}) {
    double price = double.parse(productPrice);
    double? amountAfterDeduction = 0.0;
    amountAfterDeduction = price - discount;
    placedAmount = amountAfterDeduction + deliveryCharge;
    print("Commission: $amountAfterDeduction"); // Output: 100.0
    print("amountAfterDeduction: $placedAmount"); // Output: 100.0
    return placedAmount;
  }

  int counter = 1;

  void updateCounter(bool isIncrement,int availableProductQty) {
    if (isIncrement && availableProductQty > counter ) {
      counter++;
      deBounce.run((){
        fetchCheckoutData();
      });
    } else if(isIncrement==false && counter>1){
      counter--;
      deBounce.run((){
        fetchCheckoutData();
      });
    }
  }
}
