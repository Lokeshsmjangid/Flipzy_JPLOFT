import 'dart:developer';

import 'package:flipzy/Api/api_models/products_by_category_model.dart';
import 'package:flipzy/Api/repos/category_product_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:get/get.dart';

class ProductByCategoryController extends GetxController{
  String? catID;
  String? catName;
  ProductsByCategoryModelResponse modelResponse = ProductsByCategoryModelResponse();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      catID = Get.arguments['catID'];
      catName = Get.arguments['catName'];

      log('catID:::::::$catID');
      Future.microtask((){
        fetchCatProductsListData();
      });
    }
  }




  fetchCatProductsListData({String? searchValue}) async {
    isDataLoading = true;
    update();
    await getCatProductsApi(catID: catID,searchTerm: searchValue).then((value){
      modelResponse = value;
      isDataLoading = false;
      update();
    });
  }





}