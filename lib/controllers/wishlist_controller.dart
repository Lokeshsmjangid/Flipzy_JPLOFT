import 'package:flipzy/Api/api_models/wishlist_model_response.dart';
import 'package:flipzy/Api/repos/wishlist_page_repo.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  WishlistModelResponse modelResponse = WishlistModelResponse();
  bool isDataLoading = false;

  final deBounce = Debouncer(milliseconds: 1000);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      fetchWishListData();
    });
  }

  fetchWishListData({String? searchValue}) async {
    isDataLoading = true;
    update();
    await getWishlistApi(searchTerm: searchValue).then((value){

      modelResponse = value;
      isDataLoading = false;
      update();
    });
  }
}