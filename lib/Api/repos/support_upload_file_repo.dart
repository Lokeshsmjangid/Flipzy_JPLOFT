import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/api_models/support_file_upload_model.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<SupportFileUploadModel> supportUploadApi({
  String? file_type,
  List<PlatformFile>? supportFile,
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return SupportFileUploadModel.fromJson({});
  }
  try {
    String url = ApiUrls.supportFileUploadUrl;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Headers
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
      HttpHeaders.acceptHeader: 'application/json',
    });

    request.fields['file_type'] = '${file_type}';

    // ✅ Multiple Images
    if (supportFile != null && supportFile.isNotEmpty) {
      for (final file in supportFile) {
          request.files.add(await http.MultipartFile.fromPath('file', file.path.toString()));
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
      return SupportFileUploadModel.fromJson(data);
    } else {
      log("❌ Server Error [${response.statusCode}]: $data");
      handleErrorCases(response, data, url);
    }
  }
  // on SocketException {
  //   showToastError('No Internet');
  // }
  catch (e) {
    log('❗ Error: $e');
    showToastError('$e');
  }

  return SupportFileUploadModel.fromJson({});
}
// {chatRoomId: 6805e5587fff97d4f7baf348, sender_id: 68013353bcf465bdc971de8c,
// receiver_id: 67ff932f8e7ddf59decad72c, message: q, messageType: text,
// session: true, isRead: false, _id: 6806116ecd4c96604c98d5e3, attachments: [],
// createdAt: 2025-04-21T09:35:42.394Z, updatedAt: 2025-04-21T09:35:42.394Z, __v: 0}