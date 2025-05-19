import 'dart:convert';
import 'dart:developer';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/cart_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CartResponse> cartDataApi() async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CartResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
    // "userId":"67cfbb9461b596a423277a01"
    "userId":AuthData().userModel?.id
    };


    flipzyPrint(message: '${ApiUrls.userCartsUrl}$map');
    http.Response response = await performPostRequest(ApiUrls.userCartsUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.userCartsUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CartResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.userCartsUrl);
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
  return CartResponse.fromJson({}); // please add try catch to use this
  // return CartResponse.fromJson(data); // please UnComment to print data and remove try catch
}