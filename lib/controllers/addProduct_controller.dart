import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/place_auto_complate_response.dart';
import 'package:flipzy/Api/repos/get_categories_repo.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Api/api_models/places_auto_suggestion-Starting/lib/models/autocomplate_prediction.dart';
import 'enable_location_controller.dart';

class AddProductController extends GetxController {
  final deBounce = Debouncer(milliseconds: 1000);
  int enableDisableBtn = 1;

  bool isLocalPickup = true;
  bool isReturnAvailable = false;
  bool isBeyondCity = false;
  bool isDeliveryFee = false;

  String? selectedProductCondition;
  List<String> conditionList = ["New", "Refurbished", "Old"];


  String? selectedStock;
  List<String> stokeList = ["Out of Stock", "In Stock"];

  String? selectedDeliviry;
  List<String> deliveryList = ["Yes", "No"];

  Category? selectedCategory;
  List<Category> categoryList = [];

  // List<String> categoryList = ["Electronics", "Furniture", "Fashion", "Home & Kitchen","Books","Beauty & Personal Care","Toys & Games","Automotive"];

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
                  _pickImage(ImageSource.camera); // Open the camera
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Open Gallery'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  _pickImage(ImageSource.gallery); // Open the gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      // Handle the selected image
      print('Image selected: ${image.path}');
      selectedFile.add(File(image.path));
      update();
    } else {
      print('No image selected.');
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();
    qtyCtrl.text = '1';
  }


  TextEditingController brandName = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productWeight = TextEditingController();
  TextEditingController productDL = TextEditingController(); // Dimension length
  TextEditingController productDW = TextEditingController(); // Dimension width
  TextEditingController productDH = TextEditingController(); // Dimension height
  TextEditingController qtyCtrl = TextEditingController(); // Dimension height

  CategoryModelResponse categoryModelResponse = CategoryModelResponse();

  fetchCategories() async {
    await getCategoriesApi().then((value) {
      categoryModelResponse = value;
      if (value.data != null) {
        categoryList.addAll(value.data!);
      }

      update(); // Ensure UI updates if using GetX
    });
  }
  double? amountAfterDeduction;
  double? commissionAmount;

  double? getCommissionAmount({String productPrice='0',int commissionPercent=0}) {
    double price = double.parse(productPrice);
    commissionAmount = price * commissionPercent / 100;

    print("productPrice: $productPrice"); // Output: 100.0
    print("Commission in percent: $commissionPercent"); // Output: 100.0
    amountAfterDeduction = price - commissionAmount!;
    print("Commission: $commissionAmount"); // Output: 100.0
    print("amountAfterDeduction: $amountAfterDeduction"); // Output: 100.0
    return amountAfterDeduction;
  }

  // City & Rate
  // List<Map<String, String>> cityRates = [];

  List<CityRateTextFields> cityRates=[];


  void addCityRate() {
    cityRates.add(CityRateTextFields(rateCtrl: TextEditingController(),cityCtrl: TextEditingController()));
   // cityRates.add({"city": "", "rate": ""});
    update();
  }

  // void updateCityRate(int index, String value, String key) {
  //   cityRates[index][key] = value;
  //   update();
  // }

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


class CityRateTextFields{
  TextEditingController cityCtrl;
  TextEditingController rateCtrl;
  CityRateTextFields({required this.cityCtrl,required this.rateCtrl});
}