import "dart:convert";
import "dart:developer";
import "dart:io";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/Api/api_models/home_model_response.dart";
import "package:flipzy/Api/api_models/notification_model.dart";
import "package:flipzy/Api/api_models/rating_reviews_model.dart";
import "package:flipzy/Api/api_models/seller_product_model.dart";
import "package:flipzy/Api/api_models/wishlist_model_response.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/resources/utils.dart";
import 'package:http/http.dart' as http;

Future<SellerProductsModelResponse> getSellerProductsApi({bool isBoosted= false,page,sellerID,String? searchTerm}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return SellerProductsModelResponse.fromJson({});
  }
  try{
    String? url;
    if(searchTerm!=null && searchTerm.isNotEmpty){
       url = '${ApiUrls.sellerProductUrl}/${sellerID}?searchTerm=$searchTerm&productType=$isBoosted&page=$page';
    } else{
      url = '${ApiUrls.sellerProductUrl}/${sellerID}?productType=$isBoosted&page=$page';
    }

    http.Response response = await performGetRequest(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return SellerProductsModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
    // log('message::00::$e');
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

  return SellerProductsModelResponse.fromJson({}); // please add try catch to use this
  // return CountryListResponse.fromJson(data); // please UnComment to print data and remove try catch
}