import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> removeFromCartApi({cartId}) async {
  try{
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
      "cartId":cartId,
      // "userId":"67cfbb9461b596a423277a01"
    };


    flipzyPrint(message: 'before performPostRequest::${ApiUrls.cartDeleteUrl}$map');
    http.Response response = await performPostRequest(ApiUrls.cartDeleteUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.cartDeleteUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.cartDeleteUrl);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return OrderListResponse.fromJson(data); // please UnComment to print data and remove try catch
}