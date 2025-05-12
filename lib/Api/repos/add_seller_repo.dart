import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:http/http.dart' as http;

/*
Future<CommonModelResponse> addSellerApi({businessName,storeDescription,email,mobileNumber,accountHolderName,bankName,
  accountNumber,rcNumber,businessCheck,image}) async {
  try{
    final Map<String, dynamic> map = {
    'userId':AuthData().userModel?.id,
      if(businessName!=null && businessName!='')
        'businessName':businessName,

      if(storeDescription!=null && storeDescription!='')
        'storeDescription':storeDescription,

      if(email!=null && email!='')
        'email':email,

      if(mobileNumber!=null && mobileNumber!='')
        'mobileNumber':mobileNumber,

      if(accountHolderName!=null && accountHolderName!='')
        'accountHolderName':accountHolderName,

      if(bankName!=null && bankName!='')
        'bankName':bankName,

      if(accountNumber!=null && accountNumber!='')
        'accountNumber':accountNumber,

      if(rcNumber!=null && rcNumber!='')
        'rcNumber':rcNumber,

      if(businessCheck!=null && businessCheck!='')
        'businessCheck':businessCheck,


      if(image!=null && image!='')
        'image':image,
    };


    flipzyPrint(message: '${ApiUrls.addSellerUrl},$map');
    http.Response response = await performPostRequest(ApiUrls.addSellerUrl,map);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      log("${ApiUrls.addSellerUrl}\n $map \n response Start-->\n\n $data \n\n<--response End" );
      return CommonModelResponse.fromJson(data);
    } else {
      handleErrorCases(response, data, ApiUrls.addSellerUrl);
    }
  } on SocketException catch (e) {
    showToastError('No Internet');
  }
  catch(e){
    log('$e');
    showToastError('$e');
  }
  return CommonModelResponse.fromJson({}); // please add try catch to use this
  // return CommonModelResponse.fromJson(data); // please UnComment to print data and remove try catch
}*/


Future<CommonModelResponse> addSellerApi({
  String? businessName,
  String? storeDescription,
  String? email,
  String? mobileNumber,
  String? accountHolderName,
  String? bankName,
  String? accountNumber,
  String? ifsc,
  String? rcNumber,
  bool businessCheck = false,
  File? image, // ✅ File instead of String
}) async {
  bool checkInternet = await hasInternetConnection();
  if (!checkInternet) { // checkInternet is false
    showToastError('No Internet Connection');
    return CommonModelResponse.fromJson({});
  }
  try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.addSellerUrl));

    // Headers
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}',
      HttpHeaders.acceptHeader: 'application/json',
    });

    // Fields
    request.fields['userId'] = AuthData().userModel?.id ?? '';

    if (businessName != null && businessName.isNotEmpty)
      request.fields['businessName'] = businessName;

    if (storeDescription != null && storeDescription.isNotEmpty)
      request.fields['storeDescription'] = storeDescription;

    if (email != null && email.isNotEmpty)
      request.fields['email'] = email;

    if (mobileNumber != null && mobileNumber.isNotEmpty)
      request.fields['mobileNumber'] = mobileNumber;

    if (accountHolderName != null && accountHolderName.isNotEmpty)
      request.fields['accountHolderName'] = accountHolderName;

    if (bankName != null && bankName.isNotEmpty)
      request.fields['bankName'] = bankName;

    if (accountNumber != null && accountNumber.isNotEmpty)
      request.fields['accountNumber'] = accountNumber;

    if (rcNumber != null && rcNumber.isNotEmpty)
      request.fields['rcNumber'] = rcNumber;

    if (ifsc != null && ifsc.isNotEmpty)
      request.fields['ifsc'] = ifsc;

      request.fields['businessCheck'] = businessCheck.toString();

    // Image (as multipart file)
    if (image != null && await image.exists()) {
      print('gya hai');
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    // Send Request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    var data = json.decode(response.body);
    request.fields.forEach((key, value) {
      log("  $key: $value");
    });

    if (response.statusCode == 200) {

      request.fields.forEach((key, value) {
        log("  $key: $value");
      });
      if (request.files.isNotEmpty) {
        log("🖼️ Files:");
        for (var file in request.files) {
          log("  Field: ${file.field}, Filename: ${file.filename}, Path: ${file.filename}");
        }
      } else {
        log("🖼️ No files uploaded.");
      }
      log("${ApiUrls.addSellerUrl}\n response Start-->\n\n $data \n\n<--response End");
      return CommonModelResponse.fromJson(data);
    }
    else {
      handleErrorCases(response, data, ApiUrls.addSellerUrl);
    }
  }
  // on SocketException {
  //   showToastError('No Internet');
  // }
  // catch (e) {
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

  return CommonModelResponse.fromJson({});
}