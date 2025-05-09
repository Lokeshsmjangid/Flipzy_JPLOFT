import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/initiate_payment_model.dart';
import 'package:flipzy/Api/api_models/payment_verify_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<PaymentVerifiedModel> verifyPaymentApi({productId,tx_ref,bool isBoost = false,shippingCharges,discount}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return PaymentVerifiedModel.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
    'productId':productId,
    'tx_ref':tx_ref,

      if(isBoost==false)
    'shippingCharges':shippingCharges,
      if(isBoost==false)
    'discount':discount,
    };
    String url = isBoost? ApiUrls.verifyBoostPaymentUrl : ApiUrls.verifyPaymentUrl;


    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${url}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return PaymentVerifiedModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return PaymentVerifiedModel.fromJson({}); // please add try catch to use this
  // return PaymentVerifiedModel.fromJson(data); // please UnComment to print data and remove try catch
}