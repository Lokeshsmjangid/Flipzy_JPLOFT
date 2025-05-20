import 'dart:developer';

import 'package:flipzy/Api/api_models/products_by_category_model.dart';
import 'package:flipzy/Api/repos/category_product_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductByCategoryController extends GetxController{
  ProductsByCategoryModelResponse modelResponse = ProductsByCategoryModelResponse();
  final deBounce = Debouncer(milliseconds: 1000);
  ScrollController? paginationScrollController;
  bool isDataLoading = false;
  bool isPageLoading = false;
  String? catName;
  String? catID;
  int? maxPage;
  int page =1;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      catID = Get.arguments['catID'];
      catName = Get.arguments['catName'];

      log('catID:::::::$catID');
      Future.microtask((){
        fetchCatProductsListData(pageNumm: 1);
        paginationScrollController = new ScrollController()..addListener(_scrollListener);;
      });
    }
  }

  @override
  void dispose() {
    paginationScrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    bool isLoadingAll = page > maxPage!?true:false;
    flipzyPrint(message: '${paginationScrollController?.position.atEdge}'); // allowImplicitScrolling,hasViewportDimension, keepScrollOffset
    bool isTop = paginationScrollController?.position.pixels == 0;
    flipzyPrint(message: 'isTop:::${isTop}');
    flipzyPrint(message: 'Page:::${page}');
    flipzyPrint(message: 'maxPage:::${maxPage}');
    flipzyPrint(message: 'isLoadingAll:::${isLoadingAll}');
    if(paginationScrollController!=null && paginationScrollController!.position.atEdge && isTop==false && isLoadingAll==false){
      Future.microtask((){
        deBounce.run(() {
          isPageLoading = false;
          page++;
          update();
        });

      });
    }
    if (paginationScrollController!.position.atEdge && isTop==false && isPageLoading == false) {
      if(isLoadingAll==false){
        Future.microtask((){
          fetchCatProductsListData(pageNumm: page);
        });
      }
      else{
        showToastError('That\'s all for now.');
      }
    }}

  fetchCatProductsListData({String? searchValue,pageNumm}) async {
    isPageLoading = true;
    if(page==1)
      isDataLoading =true;
    update();
    await getCatProductsApi(catID: catID,searchTerm: searchValue,page: pageNumm).then((value){

      if(page==1){
        modelResponse = value;
        isDataLoading = false;
        maxPage = value.totalPages;
      }else{
        modelResponse.data!.addAll(value.data??[]);
      }
      update();
    });
  }

}