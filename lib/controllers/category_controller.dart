import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/repos/get_categories_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  CategoryModelResponse model = CategoryModelResponse();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);
  TextEditingController searchCtrl = TextEditingController();


  int page =1;
  int? maxPage;
  bool isPageLoading = false;
  ScrollController? paginationScrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories(pageNumm: 1);
    paginationScrollController = new ScrollController()..addListener(_scrollListener);
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
          fetchCategories(pageNumm: page);
        });
      } else{
        showToastError('You reached the page limit');
      }

    }
  }

  fetchCategories({searchValue,pageNumm}) async {
    isPageLoading = true;
    if(page==1)
    isDataLoading =true;
    update();
    await getCategoriesApi(searchTerm: searchValue,page: pageNumm).then((value) {
      if(page==1){
        model = value;
        isDataLoading =false;
        maxPage = value.totalPages;
      }else{
        model.data!.addAll(value.data??[]);
      }
        update(); // Ensure UI updates if using GetX
    });
  }

}