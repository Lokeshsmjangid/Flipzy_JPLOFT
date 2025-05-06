import 'dart:io';

import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/repos/get_categories_repo.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  final deBounce = Debouncer(milliseconds: 1000);
  int enableDisableBtn = 1;

  bool isLocalPickup = true;
  bool isReturnAvailable = false;
  bool isBeyondCity = false;
  bool isDeliveryFee = false;

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


}


class CityRateTextFields{
  TextEditingController cityCtrl;
  TextEditingController rateCtrl;
  CityRateTextFields({required this.cityCtrl,required this.rateCtrl});
}