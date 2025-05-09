import "dart:io";
import "dart:convert";
import "dart:developer";
import 'package:http/http.dart' as http;
import "package:flipzy/resources/utils.dart";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/Api/api_models/my_products_model_response.dart";

Future<MyProductsModelResponse> getAllProductsListApi({page,String? searchTerm}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return MyProductsModelResponse.fromJson({});
  }
  try{
    String? url;
    if(searchTerm!=null && searchTerm.isNotEmpty){
      url = '${ApiUrls.allProductsUrl}?page=$page&searchTerm=$searchTerm';
    } else{
      url = '${ApiUrls.allProductsUrl}?page=$page';
    }
    http.Response response = await performGetRequest(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return MyProductsModelResponse.fromJson(data);
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

  return MyProductsModelResponse.fromJson({}); // please add try catch to use this
  // return MyProductsModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}