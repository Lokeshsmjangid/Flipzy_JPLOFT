import 'package:flipzy/Api/api_models/my_products_model_response.dart';
import 'package:flipzy/Api/api_models/seller_product_model.dart';
import 'package:flipzy/Api/repos/all_products_repo.dart';
import 'package:flipzy/Api/repos/seller_product_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController{

  MyProductsModelResponse modelResponse = MyProductsModelResponse();
  TextEditingController searchController = TextEditingController();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  String? searchTerm;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      searchTerm = Get.arguments['searchTerm'];
      searchController.text = '$searchTerm';
      Future.microtask((){
        fetchMyProductsListData(searchValue: searchTerm);
      });
    }
  }

  fetchMyProductsListData({searchValue}) async {
    isDataLoading = true;
    update();
    await getAllProductsListApi(searchTerm: searchValue).then((value){

      modelResponse = value;
      isDataLoading = false;
      update();
    });
  }



}