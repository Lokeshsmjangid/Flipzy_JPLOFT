import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/buy_now_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<BuyNowModelResponse> buyNowApi({productId,price,paymentStatus,paymentMethod,address}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return BuyNowModelResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
      'userId':AuthData().userModel?.id,
      'productId':productId,
      'quantity':1,
      "variations":{"new":"world"},
      "isEarningsAdded":false,
      "price":price,
      "paymentStatus":paymentStatus,
      "paymentMethod":paymentMethod,
      "address":address
    };


    flipzyPrint(message: '${ApiUrls.buyProductUrl},$map');
    http.Response response = await performPostRequest(ApiUrls.buyProductUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.buyProductUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return BuyNowModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.buyProductUrl);
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
  return BuyNowModelResponse.fromJson({}); // please add try catch to use this
  // return BuyNowModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}
