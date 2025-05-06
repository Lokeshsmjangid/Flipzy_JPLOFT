import 'package:flipzy/Api/api_models/order_detail_response.dart';
import 'package:flipzy/Api/repos/order_detail_repo.dart';
import 'package:get/get.dart';

class OrderRefundController extends GetxController{
  OrderDetailResponse response = OrderDetailResponse();
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

}