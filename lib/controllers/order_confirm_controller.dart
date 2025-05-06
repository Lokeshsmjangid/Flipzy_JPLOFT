import 'package:flipzy/Api/api_models/order_detail_response.dart';
import 'package:flipzy/Api/repos/order_detail_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderConfirmController extends GetxController{
  OrderDetailResponse response = OrderDetailResponse();
  TextEditingController declineMessage = TextEditingController();
  String? orderId;
  bool isDataLoading =false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      orderId = Get.arguments['order_id'];
      print('orderid:-->$orderId');
      print('orderid:-->$orderId');
      fetchOrderDetail();
    }
  }




  fetchOrderDetail() async{
    isDataLoading =true;
    update();
    await getOrderDetailApi(orderId: orderId).then((value){
      response = value;
      isDataLoading =false;
      update();
    });
  }

  int productTotal({int totalAmount = 0,int deliveryCharge = 0,int discount = 0 }) {
    // int totalAmount = 50000;
    // int deliveryCharge = 600;
    // int discount = 800;

    int totalPrice = totalAmount + deliveryCharge - discount;


    return totalPrice;
    print("Total Price: $totalPrice"); // Output: Total Price: 49800
  }


}