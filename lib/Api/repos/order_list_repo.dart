import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<OrderListResponse> getOrderListApi({orderStatus,String? orderId,userType}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return OrderListResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
    'orderStatus':orderStatus,
    'userType':userType,
    };


    String? url;
    if(orderId != null && orderId.isNotEmpty){
      url = '${ApiUrls.orderListUrl}?orderId=$orderId';
    }else{
      url = ApiUrls.orderListUrl;
    }

    flipzyPrint(message: 'before performPostRequest::${url} -->$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("response Start-->\n\n $data \n\n<--response End" );
      return OrderListResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }
  // catch(e){
  //   log('$e');
  //   showToastError('$e');
  // }
  catch (e) {
    if (e.toString().contains('Failed host lookup')) {
      showToastError('Cannot connect to server. Check your network or domain.');
    } else {
      showToastError('Something went wrong');
      log('❗ Something went wrong: $e');
    }
  }
  return OrderListResponse.fromJson({}); // please add try catch to use this
  // return OrderListResponse.fromJson(data); // please UnComment to print data and remove try catch
}