import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/ship_bubble_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<ShipBubbleModel> bubbleShipApi({productId}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return ShipBubbleModel.fromJson({});
  }
  try{

    String url = ApiUrls.shipBubbleUrl;
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
    'productId':productId,
    };


    flipzyPrint(message: '${url},$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${url}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return ShipBubbleModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }
  // catch(e){
  //   // log('$e');
  //   showToastError('$e');
  // }
  catch (e) {
    if (e.toString().contains('Failed host lookup')) {
      showToastError('Cannot connect to server. Check your network or domain.');
    } else {
      showToastError('Something went wrong');
      log('Something went wrong: $e');
    }
  }
  return ShipBubbleModel.fromJson({}); // please add try catch to use this
  // return ShipBubbleModel.fromJson(data); // please UnComment to print data and remove try catch
}