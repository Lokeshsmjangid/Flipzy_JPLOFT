import 'package:flipzy/Api/api_models/my_products_model_response.dart';
import 'package:flipzy/Api/api_models/seller_product_model.dart';
import 'package:flipzy/Api/repos/all_products_repo.dart';
import 'package:flipzy/Api/repos/seller_product_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController{

  MyProductsModelResponse modelResponse = MyProductsModelResponse();
  TextEditingController searchController = TextEditingController();
  bool isDataLoading = false;
  bool isPageLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  String? searchTerm;
  int page =1;
  int? maxPage;
  ScrollController? paginationScrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      searchTerm = Get.arguments['searchTerm'];
      searchController.text = '$searchTerm';
      paginationScrollController = new ScrollController()..addListener(_scrollListener);


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
    flipzyPrint(message: 'Page:::${page}');
    flipzyPrint(message: 'maxPage:::${maxPage}');
    flipzyPrint(message: 'isLoadingAll:::${isLoadingAll}');
    if(paginationScrollController!=null && paginationScrollController!.position.atEdge && isLoadingAll==false){
      Future.microtask((){
        deBounce.run(() {
          isPageLoading = false;
          page++;
          update();
        });

      });
    }
    if (paginationScrollController!.position.atEdge && isPageLoading == false) {
      // if (paginationScrollController!.position.extentAfter <= 0 && isPageLoading == false) {
      if(isLoadingAll==false){
        Future.microtask((){
          fetchMyProductsListData(pageNumm: page);
        });
      } else{
        showToastError('You reached the page limit');
      }

    }
  }

  fetchMyProductsListData({searchValue,pageNumm}) async {
    isPageLoading = true;
    if(page==1)
    isDataLoading = true;
    update();
    await getAllProductsListApi(searchTerm: searchValue,page: pageNumm).then((value){


      if (page == 1) {
        modelResponse = value;
        isDataLoading = false;
        maxPage = value.totalPages;
      }else {
        modelResponse.myProducts!.addAll(value.myProducts??[]);
      }
      update();
    });
  }



}