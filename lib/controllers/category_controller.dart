import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/repos/get_categories_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  CategoryModelResponse model = CategoryModelResponse();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);
  TextEditingController searchCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();
  }


  fetchCategories({searchValue}) async {
    isDataLoading =true;
    update();
    await getCategoriesApi(searchTerm: searchValue).then((value) {
      model = value;
      isDataLoading =false;

      update(); // Ensure UI updates if using GetX
    });
  }

}