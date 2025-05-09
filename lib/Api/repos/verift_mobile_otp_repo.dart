import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> verifyMobileOTPApi({mobileNumber,otp}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
    'mobileNumber':mobileNumber,
    'otp':otp,
    };


    flipzyPrint(message: '${ApiUrls.verifyMobileOtpUrl}$map');
    http.Response response = await performPostRequest(ApiUrls.verifyMobileOtpUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.verifyMobileOtpUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.verifyMobileOtpUrl);
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
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}