import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/boost_plans_model.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<BoostPlansModel> boostPlansApi() async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return BoostPlansModel.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {};


    flipzyPrint(message: '${ApiUrls.boostPlaneUrl},$map');
    http.Response response = await performPostRequest(ApiUrls.boostPlaneUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.boostPlaneUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return BoostPlansModel.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.boostPlaneUrl);
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
  return BoostPlansModel.fromJson({}); // please add try catch to use this
  // return BoostPlansModel.fromJson(data); // please UnComment to print data and remove try catch
}
