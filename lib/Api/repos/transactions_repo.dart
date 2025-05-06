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
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return TransactionResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}