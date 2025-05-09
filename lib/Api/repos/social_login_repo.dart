import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> socialLoginApi({firstName,lastName,email,social_id,login_type}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try{
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    String url = ApiUrls.socialLoginUrl;
    final Map<String, dynamic> map = {
    'firstName':firstName,
    'lastName':lastName,
    'email':email,
    'social_id':social_id,
    'login_type':login_type,
    'fcmToken':fcmToken,
    };
    flipzyPrint(message: '${url}$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${url}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
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
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}