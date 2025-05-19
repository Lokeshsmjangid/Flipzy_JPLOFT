import 'package:flipzy/Api/api_models/my_products_model_response.dart';
import 'package:flipzy/Api/api_models/seller_product_model.dart';
import 'package:flipzy/Api/repos/all_products_repo.dart';
import 'package:flipzy/Api/repos/seller_product_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController{

  TextEditingController srchCtrl = TextEditingController();
  SellerProductsModelResponse modelResponse = SellerProductsModelResponse();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);
  int selectedTab = 1;

  // pagination

  int page =1;
  int? maxPage;
  bool isPageLoading = false;
  ScrollController? paginationScrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      fetchMyProductsListData();
      paginationScrollController = new ScrollController()..addListener(_scrollListener);
    });
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
      // if (paginationScrollController!.position.extentAfter <= 0 && isPageLoading == false) {
      if(isLoadingAll==false){
        Future.microtask((){
          fetchMyProductsListData();
        });
      } else{
        showToastError('You reached the page limit');
      }

    }
  }

  fetchMyProductsListData({String? searchValue}) async {
    isPageLoading = true;
    if(page==1)
    isDataLoading = true;
    update();
    await getSellerProductsApi(
        sellerID: AuthData().userModel?.id,
        isBoosted: selectedTab==1?true:false,
        page: page,
        searchTerm: searchValue).then((value){


      if (page == 1) {
        modelResponse = value;
        isDataLoading = false;
        maxPage = value.totalPages;
      }else {
        if(modelResponse.data!=null)
        modelResponse.data!.listProducts!.addAll(value.data!.listProducts??[]);
      }
      update();

    });
  }



}