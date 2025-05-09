import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> loginApi({email,password}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try{

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    final Map<String, dynamic> map = {
    'email':email,
    'password':password,
    'fcmToken':fcmToken,
    };


    flipzyPrint(message: '${ApiUrls.loginUrl}$map\n FCM_TOKEN-->$fcmToken<--');
    http.Response response = await performPostRequest(ApiUrls.loginUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.loginUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.loginUrl);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  // }

  catch(e){
    log('$e');
    showToastError('$e');
  }
  // catch (e, stackTrace) {
  //   log('Login API Error: $e\nStackTrace: $stackTrace');
  //   showToastError('Something went wrong. Please try again.');
  // }
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}