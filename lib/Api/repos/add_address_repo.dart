import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/address_common_model.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<AddressCommonModel> addAddressApi({bool isEdit = false,String? addressId,double? lat,double? lang,
  String? address,String? landmark,
  String? city,String? state,
  String? country,String? zipCode
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return AddressCommonModel.fromJson({});
  }
  try{

    String url = isEdit?'${ApiUrls.editAddressUrl}/${addressId}':ApiUrls.addAddressUrl;
    final Map<String, dynamic> map = {
      "userId": AuthData().userModel?.id,
      "lat": lat,
      "long": lang,
      "city": city,
      "state": state,
      "country": country,
      "address": address,
      "zipcode": zipCode,
      "landmark": landmark
    };


    flipzyPrint(message: '${url},$map');
    http.Response response = await performPostRequest(url,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return AddressCommonModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
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
  return AddressCommonModel.fromJson({}); // please add try catch to use this
  // return AddressCommonModel.fromJson(data); // please UnComment to print data and remove try catch
}