import "dart:convert";
import "dart:developer";
import "dart:io";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/Api/api_models/category_model.dart";
import "package:flipzy/Api/api_models/home_model_response.dart";
import "package:flipzy/Api/api_models/user_available_balance_model.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/resources/utils.dart";
import 'package:http/http.dart' as http;

Future<UserBalanceResponse> getUserBalanceApi() async {
  try{

    // String url = ApiUrls.categoriesListUrl;
    String? url;

      url = '${ApiUrls.allTransactionsUrl}/${AuthData().userModel?.id}';

    log('message:::$url');

    http.Response response = await performGetRequest(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return UserBalanceResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
    // log('message::00::$e');
  }catch(e)
  {
    showToastError('$e');
  }

  return UserBalanceResponse.fromJson({}); // please add try catch to use this
  // return CountryListResponse.fromJson(data); // please UnComment to print data and remove try catch
}