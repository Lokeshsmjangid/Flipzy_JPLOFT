import 'package:flipzy/Api/api_models/cart_response.dart';
import 'package:flipzy/Api/repos/cart_data_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  CartResponse response = CartResponse();
  bool isDataLoading = false;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCartData();
  }

  fetchCartData() async{
    isDataLoading = true;
    update();
    cartDataApi().then((value){
      response = value;
      isDataLoading = false;
      update();
    });
  }

  itemTotalPrice(dynamic a,dynamic b) {

    dynamic result = a * b; // Multiplication

    print("Multiplication of $a and $b is: $result");
    return result;
  }





}