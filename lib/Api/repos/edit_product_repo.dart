import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/controllers/edit_product_controller.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> editProductApi({
  String? productId,
  String? brandName,
  String? productName,
  String? productCondition,
  String? pickupLocation,
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
  List<CityRateTextFields>? delivery, // Multiple rates
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
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.editProductUrl));

    // Headers
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
      HttpHeaders.acceptHeader: 'application/json',
    });

    // Required
    // request.fields['sellerId'] = AuthData().userModel?.id ?? '';

    // Optional Fields
    request.fields['userId'] = '${AuthData().userModel?.id}';
    request.fields['productId'] = productId??'';
    if (brandName?.isNotEmpty ?? false) request.fields['brandName'] = brandName!;
    if (productName?.isNotEmpty ?? false) request.fields['productName'] = productName!;
    if (productCondition?.isNotEmpty ?? false) request.fields['productCondition'] = productCondition!;
    if (pickupLocation?.isNotEmpty ?? false) request.fields['pickupLocation'] = pickupLocation!;
    if (catagory?.isNotEmpty ?? false) request.fields['category'] = catagory!;
    if (price?.isNotEmpty ?? false) request.fields['price'] = price!;
    if (commission?.isNotEmpty ?? false) request.fields['commission'] = commission!;
    if (amountAfterDeduction?.isNotEmpty ?? false) request.fields['amountAfterDeduction'] = amountAfterDeduction!;
    if (productDescription?.isNotEmpty ?? false) request.fields['productDescription'] = productDescription!;
    if (stockQuantity?.isNotEmpty ?? false) request.fields['stockQuantity'] = stockQuantity!;
    if (productWeight?.isNotEmpty ?? false) request.fields['productWeight'] = productWeight!;
    if (productDimentions?.isNotEmpty ?? false) request.fields['productDimentions'] = productDimentions!;
    if (localPickUp?.isNotEmpty ?? false) request.fields['localPickUp'] = localPickUp!;
    if (isReturnAvailable?.isNotEmpty ?? false) request.fields['isReturnAvailable'] = isReturnAvailable!;
    if (deliveryFee?.isNotEmpty ?? false) request.fields['deliveryFee'] = deliveryFee!;
    if (sellBeyondCityLimits?.isNotEmpty ?? false) request.fields['sellBeyondCityLimits'] = sellBeyondCityLimits!;
    if (stock?.isNotEmpty ?? false) request.fields['stock'] = stock!;

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
     /* for (int i = 0; i < delivery.length; i++) {
        request.fields.addAll({
          // 'deliveryCity': deliveryCity[0],
          // 'deliveryRate': deliveryRate.length > i ? deliveryRate[0] : '',
          'deliveryCity': delivery[0].cityCtrl.text.toString(),
          'deliveryRate': delivery[0].rateCtrl.text.toString(),
        });
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
    log("🔰 API: ${ApiUrls.editProductUrl}");
    request.fields.forEach((k, v) => log("📝 Field: $k = $v"));
    request.files.forEach((f) => log("📦 File: ${f.filename}"));

    if (response.statusCode == 200) {
      log("✅ Response: $data");
      return CommonModelResponse.fromJson(data);
    } else {
      log("❌ Server Error [${response.statusCode}]: $data");
      handleErrorCases(response, data, ApiUrls.editProductUrl);
    }
  }
  // on SocketException {
  //   showToastError('No Internet');
  // }
  // catch (e) {
  //   log('❗ Error: $e');
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

  return CommonModelResponse.fromJson({});
}
