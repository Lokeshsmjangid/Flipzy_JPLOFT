import 'package:flipzy/Api/api_models/order_detail_response.dart';
import 'package:flipzy/Api/repos/order_detail_repo.dart';
import 'package:get/get.dart';

class OrderChangeStatusController extends GetxController{
  OrderDetailResponse response = OrderDetailResponse();
  String? orderId;
  int? buttonStep;
  String? buttonTxt;
  bool isDataLoading =false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      orderId = Get.arguments['order_id'];
      buttonStep = Get.arguments['button_step'];
      print('orderid:-->$orderId');
      print('buttonStep:-->$buttonStep');
      print('buttonTxt:-->$buttonTxt');
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
      if(response.data!=null){
        String orderStatus = response.data![0].orderStatus.toString();
        buttonTxt = buttonStep==0?'Ready To Pickup': buttonStep==1?'Mark As Shipped':buttonStep==2
            ? orderStatus == 'InTransit'? 'In Transit':'Out For Delivery':buttonStep==3?'Delivered':'';
      }
    });
  }


  int productTotal({int totalAmount = 0,int deliveryCharge = 0,int discount = 0 }) {

    int totalPrice = totalAmount + deliveryCharge - discount;
    return totalPrice;
    print("Total Price: $totalPrice"); // Output: Total Price: 49800
  }

}