import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/change_order_status_model.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/order_detail_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<OrderStatusResponse> changeOrderStatusApi({orderId,orderStatus}) async {
  try{
    final Map<String, dynamic> map = {
      'orderId':orderId,
      'orderStatus':orderStatus,
    };


    flipzyPrint(message: '${ApiUrls.changeOrderStatusUrl},$map');
    http.Response response = await performPostRequest(ApiUrls.changeOrderStatusUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.changeOrderStatusUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return OrderStatusResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.changeOrderStatusUrl);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return OrderStatusResponse.fromJson({}); // please add try catch to use this
  // return OrderStatusResponse.fromJson(data); // please UnComment to print data and remove try catch
}