import 'package:flipzy/Api/api_models/my_products_model_response.dart';
import 'package:flipzy/Api/api_models/seller_product_model.dart';
import 'package:flipzy/Api/repos/all_products_repo.dart';
import 'package:flipzy/Api/repos/seller_product_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController{

  SellerProductsModelResponse modelResponse = SellerProductsModelResponse();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      fetchMyProductsListData();
    });
  }

  fetchMyProductsListData({String? searchValue}) async {
    isDataLoading = true;
    update();
    await getSellerProductsApi(sellerID: AuthData().userModel?.id,searchTerm: searchValue).then((value){
      modelResponse = value;
      isDataLoading = false;
      update();
    });
  }



}