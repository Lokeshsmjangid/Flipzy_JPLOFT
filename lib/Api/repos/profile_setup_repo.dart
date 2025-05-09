import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

Future<CommonModelResponse> profileSetupApi({
  required String mobileNumber,
  required String name,
  required String lName,
  required String email,
  required String location,
  required String password,
  File? image,
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.profileSetUpUrl));

    // Add headers
    request.headers.addAll({
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
    });

    // Add fields
    request.fields['mobileNumber'] = mobileNumber;
    request.fields['firstname'] = name;
    request.fields['lastname'] = lName;
    request.fields['email'] = email;
    request.fields['location'] = location;

    if(password.isNotEmpty)
    request.fields['password'] = password;
    request.fields['fcmToken'] = fcmToken!;


    // Add image if available
    if (image != null && await image.exists()) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    // Log request before sending
    log("🔽 Profile Setup Request Fields:");
    request.fields.forEach((key, value) {
      log("  $key: $value");
    });

    if (request.files.isNotEmpty) {
      log("🖼️ Files:");
      for (var file in request.files) {
        log("  Field: ${file.field}, Filename: ${file.filename}, Path: ${file.filename}");
      }
    }
    else {
      log("🖼️ No files uploaded.");
    }

    // Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.profileSetUpUrl} \n✅ Response Start:\n$data\n✅ Response End");
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.profileSetUpUrl);
    }
  }
  // on SocketException {
  //   showToastError('No Internet');
  // }
  catch (e) {
    log('❌ $e');
    showToastError('$e');
  }

  return CommonModelResponse.fromJson({});
}
