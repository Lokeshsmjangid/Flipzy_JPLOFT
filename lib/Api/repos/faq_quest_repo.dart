import "dart:convert";
import "dart:developer";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/Api/api_models/faq_model_response.dart";
import "package:flipzy/Api/api_models/products_by_category_model.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/resources/utils.dart";
import 'package:http/http.dart' as http;

Future<FrequentlyAskQuestionsModel> faqApi() async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return FrequentlyAskQuestionsModel.fromJson({});
  }
  try{
    String url = ApiUrls.faqUrl;

    flipzyPrint(message: 'Url=>$url');
    http.Response response = await performGetRequest(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("$url response Start-->\ntoken ${AuthData().userToken}\n $data \n\n<--response End" );
      return FrequentlyAskQuestionsModel.fromJson(data);
    } else {
      handleErrorCases(response, data, url);
    }
  }
  catch (e) {
    if (e.toString().contains('Failed host lookup')) {
      showToastError('Cannot connect to server. Check your network or domain.');
    } else {
      showToastError('Something went wrong');
      log('❗ Something went wrong: $e');
    }
  }

  return FrequentlyAskQuestionsModel.fromJson({}); // please add try catch to use this
  // return CountryListResponse.fromJson(data); // please UnComment to print data and remove try catch
}