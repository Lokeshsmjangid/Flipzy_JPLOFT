import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/address_common_model.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<AddressCommonModel> defaultAddressApi({String? addressId,

}) async {
  try{

    String url = '${ApiUrls.defaultAddressUrl}/${addressId}';
    final Map<String, dynamic> map = {};


    flipzyPrint(message: '${url},$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return AddressCommonModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return AddressCommonModel.fromJson({}); // please add try catch to use this
  // return AddressCommonModel.fromJson(data); // please UnComment to print data and remove try catch
}