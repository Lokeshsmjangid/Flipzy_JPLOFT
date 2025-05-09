import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/checkout_detail_model.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CheckOutDetailModel> checkOutDetailApi({productId,String? promoCode}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CheckOutDetailModel.fromJson({});
  }
  try{

    String url = ApiUrls.checkoutDetailsUrl;
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
    'productId':productId,
    if(promoCode!=null)
    'promoCode':promoCode,
    };


    flipzyPrint(message: '${url},$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${url}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CheckOutDetailModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }
  catch(e){
    // log('$e');
    showToastError('$e');
  }
  return CheckOutDetailModel.fromJson({}); // please add try catch to use this
  // return CheckOutDetailModel.fromJson(data); // please UnComment to print data and remove try catch
}