import 'package:flipzy/Api/api_models/boost_products_list_model.dart';
import 'package:flipzy/Api/repos/boost_products_repo.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:get/get.dart';

class BoostProductController extends GetxController {
  BoostProductsModelResponse modelResponse = BoostProductsModelResponse();
  bool isDataLoading = false;


  int? selectedBox;

  int? boostedCount;
  int? activeCount;
  int? allCount;

  final deBounce = Debouncer(milliseconds: 1000);



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      selectedBox = Get.arguments['selectedBox']??3;

      Future.microtask((){
        fetchBoostListData();
      });
    }



  }

  fetchBoostListData({String? searchValue}) async {
    isDataLoading = true;
    update();
    await getBoostProductsListApi(searchTerm: searchValue).then((value){

      modelResponse = value;
      if(value.data!=null)
        boostedCount = value.data!.boostProducts;
        activeCount = value.data!.activeProducts;
        allCount = value.data!.totalProducts;
      isDataLoading = false;
      update();
    });
  }
}
