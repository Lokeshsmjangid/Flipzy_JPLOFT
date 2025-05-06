import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> applyProductReturnApi({
  String? orderId,
  String? reason,
  String? reasonType,
  List<File>? productImages, // Multiple image files
}) async {
  try {
    String url = '${ApiUrls.applyProductReturnUrl}/$orderId';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Headers
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
      HttpHeaders.acceptHeader: 'application/json',
    });

    // Required
    request.fields['userId'] = AuthData().userModel?.id ?? '';

    // Optional Fields
    if (reason?.isNotEmpty ?? false) request.fields['reason'] = reason!;
    if (reasonType?.isNotEmpty ?? false) request.fields['reasonType'] = reasonType!;

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
    log("🔰 API: ${url}");
    request.fields.forEach((k, v) => log("📝 Field: $k = $v"));
    request.files.forEach((f) => log("📦 File: ${f.filename}"));

    if (response.statusCode == 200) {
      log("✅ Response: $data");
      return CommonModelResponse.fromJson(data);
    } else {
      log("❌ Server Error [${response.statusCode}]: $data");
      handleErrorCases(response, data, url);
    }
  } on SocketException {
    showToastError('No Internet');
  } catch (e) {
    log('❗ Error: $e');
    showToastError('$e');
  }

  return CommonModelResponse.fromJson({});
}
// {chatRoomId: 6805e5587fff97d4f7baf348, sender_id: 68013353bcf465bdc971de8c,
// receiver_id: 67ff932f8e7ddf59decad72c, message: q, messageType: text,
// session: true, isRead: false, _id: 6806116ecd4c96604c98d5e3, attachments: [],
// createdAt: 2025-04-21T09:35:42.394Z, updatedAt: 2025-04-21T09:35:42.394Z, __v: 0}