import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> addProductApi({
  String? brandName,
  String? productName,
  String? catagory, // 🔁 Rename to 'category' if backend expects that
  String? price,
  String? commission,
  String? amountAfterDeduction,
  String? productDescription,
  String? stockQuantity,
  String? productWeight,
  String? productDimentions,
  String? localPickUp,
  String? isReturnAvailable,
  String? deliveryFee,
  List<CityRateTextFields>? delivery, // Multiple cities
  String? sellBeyondCityLimits,
  String? stock,
  List<File>? productImages, // Multiple image files
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.addProductUrl));

    // Headers
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
      HttpHeaders.acceptHeader: 'application/json',
    });

    // Required
    request.fields['sellerId'] = AuthData().userModel?.id ?? '';

    // Optional Fields
    if (brandName?.isNotEmpty ?? false) request.fields['brandName'] = brandName!;
    if (productName?.isNotEmpty ?? false) request.fields['productName'] = productName!;
    if (catagory?.isNotEmpty ?? false) request.fields['category'] = catagory!;
    if (price?.isNotEmpty ?? false) request.fields['price'] = price!;
    if (commission?.isNotEmpty ?? false) request.fields['commission'] = commission!;
    if (amountAfterDeduction?.isNotEmpty ?? false) request.fields['amountAfterDeduction'] = amountAfterDeduction!;
    if (productDescription?.isNotEmpty ?? false) request.fields['productDescription'] = productDescription!;
    if (stockQuantity?.isNotEmpty ?? false) request.fields['stockQuantity'] = stockQuantity!;
    if (productWeight?.isNotEmpty ?? false) request.fields['productWeight'] = productWeight!;
    if (productDimentions?.isNotEmpty ?? false) request.fields['productDimentions'] = productDimentions!;
    if (localPickUp?.isNotEmpty ?? false) request.fields['localPickUp'] = localPickUp!;
    if (deliveryFee?.isNotEmpty ?? false) request.fields['deliveryFee'] = deliveryFee!;
    if (sellBeyondCityLimits?.isNotEmpty ?? false) request.fields['sellBeyondCityLimits'] = sellBeyondCityLimits!;
    if (stock?.isNotEmpty ?? false) request.fields['stock'] = stock!;
    if (isReturnAvailable?.isNotEmpty ?? false) request.fields['isReturnAvailable'] = isReturnAvailable!;


    // ✅ Multiple deliveryCity and deliveryRate (flat form key=value pairs)
    if (delivery != null) {
      print('comming:::::: for cities${delivery}');
      List<Map<String, String>> cityRateMapList = delivery.map((item) {
        return {
          'city': item.cityCtrl.text,
          'rate': item.rateCtrl.text,
        };
      }).toList();


      log('message:::::${cityRateMapList}');
      request.fields['shippingCharges'] = jsonEncode(cityRateMapList);

      /*for (int i = 0; i < delivery.length; i++) {
        request.fields.addAll({
          // 'deliveryCity': deliveryCity[0],
          // 'deliveryRate': deliveryRate.length > i ? deliveryRate[0] : '',
          'deliveryCity': delivery[0].cityCtrl.text.toString(),
          'deliveryRate': delivery[0].rateCtrl.text.toString(),
        });
        //print('comming::index::::${deliveryCity[0]} for cities  ${deliveryRate[0]}');
      }*/

    }

    // ✅ Multiple Images
    if (productImages != null && productImages.isNotEmpty) {
      for (final image in productImages) {
        if (await image.exists()) {
          request.files.add(await http.MultipartFile.fromPath('productImages', image.path));
        }
      }
    }

    // Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var data = json.decode(response.body);

    // ✅ Log for debugging
    log("🔰 API: ${ApiUrls.addProductUrl}");
    request.fields.forEach((k, v) => log("📝 Field: $k = $v"));
    request.files.forEach((f) => log("📦 File: ${f.filename}"));

    if (response.statusCode == 200) {
      log("✅ Response: $data");
      return CommonModelResponse.fromJson(data);
    } else {
      log("❌ Server Error [${response.statusCode}]: $data");
      handleErrorCases(response, data, ApiUrls.addProductUrl);
    }
  }
  // on SocketException {
  //   showToastError('No Internet');
  // }
  catch (e) {
    log('❗ Error: $e');
    showToastError('$e');
  }

  return CommonModelResponse.fromJson({});
}
// {chatRoomId: 6805e5587fff97d4f7baf348, sender_id: 68013353bcf465bdc971de8c,
// receiver_id: 67ff932f8e7ddf59decad72c, message: q, messageType: text,
// session: true, isRead: false, _id: 6806116ecd4c96604c98d5e3, attachments: [],
// createdAt: 2025-04-21T09:35:42.394Z, updatedAt: 2025-04-21T09:35:42.394Z, __v: 0}