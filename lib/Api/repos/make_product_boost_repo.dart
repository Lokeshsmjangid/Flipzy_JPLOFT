import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> makeBoostProductApi({productId,boostPrice,boostTime}) async {
  try{
    final Map<String, dynamic> map = {
    'sellerId':AuthData().userModel?.id,
    'productId':productId,
    'boostPrice':boostPrice,
    'boostTime':boostTime,
    };


    flipzyPrint(message: '${ApiUrls.makeProductBoostUrl},$map');
    http.Response response = await performPostRequest(ApiUrls.makeProductBoostUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.makeProductBoostUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.makeProductBoostUrl);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}