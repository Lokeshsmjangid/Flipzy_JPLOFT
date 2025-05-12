import "dart:io";
import "dart:convert";
import "dart:developer";
import "package:flipzy/Api/api_models/transaction_response.dart";
import 'package:http/http.dart' as http;
import "package:flipzy/resources/utils.dart";
import "package:flipzy/Api/api_constant.dart";
import "package:flipzy/resources/auth_data.dart";
import "package:flipzy/Api/api_models/my_products_model_response.dart";

Future<TransactionResponse> allTransactionsApi() async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return TransactionResponse.fromJson({});
  }
  try{
    final Map<String, dynamic> map = {
      'userId':AuthData().userModel?.id,
    };


    flipzyPrint(message: '${ApiUrls.allTransactionsUrl}$map');
    http.Response response = await performPostRequest(ApiUrls.allTransactionsUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.allTransactionsUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return TransactionResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.allTransactionsUrl);
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
  return TransactionResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}