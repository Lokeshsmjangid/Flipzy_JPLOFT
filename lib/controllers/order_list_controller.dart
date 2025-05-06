import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/Api/repos/order_list_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController{



  OrderListResponse response = OrderListResponse();
  double initialRating = 1.0;
  int selectedTab = 1;
  bool isOrderHistory = false;
  String? userType;
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController ratingCtrl = TextEditingController();
  TextEditingController declineMessage = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      isOrderHistory = Get.arguments['is_order_history'];
      isOrderHistory = Get.arguments['is_order_history'];
      userType = Get.arguments['userType'];
      print('is_order_history::::${isOrderHistory}');
    }

    fetchOrderList();
  }
  fetchOrderList({orderId}){
    isDataLoading = true;
    update();
    getOrderListApi(orderStatus:
    selectedTab==0?isOrderHistory==true? 'Processing':'': // request data for '' and Pending
    selectedTab==1?isOrderHistory==true?'Shipped':'Processing':
    selectedTab==2?isOrderHistory==true?'Refund_Return':'Shipped':
    selectedTab==3?'Delivered':
    selectedTab==4?'Refund_Return':'',
        orderId: orderId,
        userType: userType).then((value){
      response =value;
      isDataLoading = false;
      update();

    });
  }}