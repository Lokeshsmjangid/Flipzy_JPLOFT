import "dart:convert";
import "dart:developer";
import "dart:io";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/Api/api_models/home_model_response.dart";
import "package:flipzy/Api/api_models/notification_model.dart";
import "package:flipzy/Api/api_models/products_by_category_model.dart";
import "package:flipzy/Api/api_models/rating_reviews_model.dart";
import "package:flipzy/Api/api_models/seller_product_model.dart";
import "package:flipzy/Api/api_models/wishlist_model_response.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/resources/utils.dart";
import 'package:http/http.dart' as http;

Future<ProductsByCategoryModelResponse> getCatProductsApi({catID,page,String? searchTerm}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return ProductsByCategoryModelResponse.fromJson({});
  }
  try{
    String? url;
    if(searchTerm!=null && searchTerm.isNotEmpty){
       url = '${ApiUrls.productByCategoryUrl}/${catID}?page=$page&searchTerm=$searchTerm';
    } else{
      url = '${ApiUrls.productByCategoryUrl}/${catID}?page=$page';
    }
    flipzyPrint(message: 'Url=>$url');
    http.Response response = await performGetRequest(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return ProductsByCategoryModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException catch (e) {
  //   showToastError('No Internet');
  //  // log('message::00::$e');
  // }
  catch(e)
  {
    showToastError('$e');
  }

  return ProductsByCategoryModelResponse.fromJson({}); // please add try catch to use this
  // return CountryListResponse.fromJson(data); // please UnComment to print data and remove try catch
}