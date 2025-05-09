import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/order_list_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> giveRatingApi({
  productId,
  userDescription,
  userRating
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
      'orderId':productId,
      'userDescription':userDescription,
      'userRating':userRating,

    };


    flipzyPrint(message: 'before performPostRequest::${ApiUrls.addReviewUrl}$map');
    http.Response response = await performPostRequest(ApiUrls.addReviewUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.addReviewUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.addReviewUrl);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return OrderListResponse.fromJson(data); // please UnComment to print data and remove try catch
}