import "dart:convert";
import "dart:developer";
import "dart:io";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/Api/api_models/address_response_model.dart";
import "package:flipzy/Api/api_models/home_model_response.dart";
import "package:flipzy/Api/api_models/notification_model.dart";
import "package:flipzy/Api/api_models/products_by_category_model.dart";
import "package:flipzy/Api/api_models/rating_reviews_model.dart";
import "package:flipzy/Api/api_models/seller_product_model.dart";
import "package:flipzy/Api/api_models/wishlist_model_response.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/resources/utils.dart";
import 'package:http/http.dart' as http;

Future<AddressResponseModel> getAllAddressApi() async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return AddressResponseModel.fromJson({});
  }
  try{
    String url = '${ApiUrls.getAllAddressUrl}/${AuthData().userModel?.id}';

    http.Response response = await performGetRequest(url);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return AddressResponseModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  //  // log('message::00::$e');
  // }
  // catch(e)
  // {
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

  return AddressResponseModel.fromJson({}); // please add try catch to use this
  // return CountryListResponse.fromJson(data); // please UnComment to print data and remove try catch
}