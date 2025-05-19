import 'dart:developer';

import 'package:flipzy/Api/api_models/product_detail_model.dart';
import 'package:flipzy/Api/repos/product_detail_repo.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  ProductDetailResponse response = ProductDetailResponse();
  bool isDataLoading = false;
  String? productId;
  String? productName;
  List<String>? productImages;
  int currentIndex = 0;
  TextEditingController repportCtrl = TextEditingController();

  // Navigate to the previous image.
  void goToPreviousImage() {
    if (currentIndex > 0) {
      currentIndex = currentIndex - 1;
      update();
      log('goToPreviousImage==> ${currentIndex}');
    }
  }

  void goToNextImage() {
    if (currentIndex < productImages!.length - 1) {
      currentIndex = currentIndex + 1;
      update();
      log('goToNextImage==> ${currentIndex}');
    }
  }
  void onThumbnailTap(int index) {
    currentIndex = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      productId = Get.arguments['product_id'];
      productName = Get.arguments['product_name'];

      flipzyPrint(message: 'product_id::::${productId} && productName::::${productName}');

      fetchPDetail();
    }
  }
  fetchPDetail() async{
    isDataLoading = true;
    update();
    await getProductDetailApi(productId: productId).then((value){

      response = value;
      if (value.data != null) {
        productImages ??= []; // Initialize if null
        productImages!.addAll(value.data!.productList!.productImages ?? []);
      }

      isDataLoading = false;
      update();
    });
  }

  int counter = 1;

  void updateCounter(bool isIncrement,int availableProductQty) {
    if (isIncrement && availableProductQty > counter ) {
      counter++;
    } else if(isIncrement==false && counter>1){

      counter--;
    }
  }


}