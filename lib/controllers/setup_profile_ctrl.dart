import 'dart:developer';
import 'dart:io';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/place_auto_complate_response.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/autocomplate_prediction.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'enable_location_controller.dart';

class SetUpProfileCtrl extends GetxController{
  final deBounce = Debouncer(milliseconds: 1000);
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool obsurePass = true;
  ontapPassSuffix(){
    obsurePass = !obsurePass;
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(AuthData().userModel!=null){
      mobileCtrl.text = AuthData().userModel?.mobileNumber.toString()??'';
      fNameCtrl.text = AuthData().userModel?.firstname??'';
      lNameCtrl.text = AuthData().userModel?.lastname??'';
      emailCtrl.text = AuthData().userModel?.email??'';
      locationCtrl.text = AuthData().userModel?.location??'';
      passwordCtrl.text = AuthData().userModel?.password??'';
    }
  }

  List<File?> selectedFile = [];
  void showCameraGalleryDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  pickImage(ImageSource.camera); // Open the camera
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Open Gallery'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  pickImage(ImageSource.gallery); // Open the gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedFile.clear();
      // Handle the selected image
      print('Image selected: ${image.path}');
      selectedFile.add(File(image.path)) ;
      update();
    } else {
      print('No image selected.');
    }
  }


  // for pickup location
  List<AutocompletePrediction> placePredication = [];
  void getSuggestion(String query) async{
    Uri uri = Uri.https('maps.googleapis.com','maps/api/place/autocomplete/json',{
      'key': ApiUrls.googleApiKey,
      'input': query,
      'components': 'country:ng', // only for nigeria
    });

    String? response = await fetchUrl(uri);
    if(response !=null){
      log('AutoCompleteResponse $response');
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if(result.predictions!=null){
        placePredication = result.predictions!;
        update();
      }
    }

  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers); // Await the HTTP request
      if (response.statusCode == 200) {
        // Do something with the response here if needed
        return response.body; // Return response body or whatever you need
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  Future<PlaceDetails> getAddressFromPlaceId(String placeId) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,geometry&key=${ApiUrls.googleApiKey}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final addressComponents = data['result']['address_components'];
      final geometry = data['result']['geometry'];

      String address = '';
      String city = '';
      String state = '';
      String country = '';
      String postalCode = '';
      double latitude = 0.0;
      double longitude = 0.0;

      for (var component in addressComponents) {

        List<dynamic> types = component['types'];
        if (types.contains('street_number') || types.contains('route')) {
          address += component['long_name'] + ', ';
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          state = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      latitude = geometry['location']['lat'];
      longitude = geometry['location']['lng'];
      showLoader(false);
      return PlaceDetails(
        responseCode: 200,
        address: address.isEmpty ? '' : address.substring(0, address.length - 2),
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
        latitude: latitude,
        longitude: longitude,
      );
    } else {
      showLoader(false);

      throw Exception('Failed to load place details');
    }
  }

}