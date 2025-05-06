import 'dart:convert';
import 'dart:io';

import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/get_categories_repo.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProductController extends GetxController {
  final deBounce = Debouncer(milliseconds: 1000);
  Product? editProduct;
  int enableDisableBtn =0;
  bool? isLocalPickup;
  bool isReturnAvailable = false;
  bool? isBeyondCity;
  bool? isDeliveryFee;


  String? selectedStock;
  List<String> stokeList = ["Out of Stock", "In Stock"];


  // List<String> categoryList = ["Electronics", "Furniture", "Fashion", "Home & Kitchen","Books","Beauty & Personal Care","Toys & Games","Automotive"];





  String? selectedDeliviry;
  List<String> deliveryList = ["Yes", "No"];
  //on tap add more



  // City & Rates
  // List<Map<String, String>> cityRates = [{"city": "", "rate": ""}];
  List<CityRateTextFields> cityRates=[];
  void addCityRate({city,rate}) {
    cityRates.add(CityRateTextFields(
        rateCtrl: TextEditingController(text: rate.toString()),
        cityCtrl: TextEditingController(text: city)));
    // cityRates.add({"city": "", "rate": ""});
    update();
  }

  // void updateCityRate(int index, String value, String key) {
  //   cityRates[index][key] = value;
  //   update();
  // }



  TextEditingController brandName = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productWeight = TextEditingController();
  TextEditingController productDL = TextEditingController(); // Dimension length
  TextEditingController productDW = TextEditingController(); // Dimension width
  TextEditingController productDH = TextEditingController(); // Dimension height
  TextEditingController qtyCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      editProduct = Get.arguments['editProduct'];
      if(editProduct!=null){
        
        Future.microtask((){
          flipzyPrint(message: 'Edit Product::::\n ${jsonEncode(editProduct)}');
          isLocalPickup = editProduct!.localPickUp;
          isReturnAvailable = editProduct!.isReturnAvailable!;
          isBeyondCity = editProduct!.sellBeyondCityLimits=='Yes'?true:false;
          // isDeliveryFee = editProduct!.deliveryRate !=0?true:false;
          isDeliveryFee = editProduct!.deliveryFee;
          editProduct!.sellBeyondCityLimits=='Yes'?selectedDeliviry='Yes':selectedDeliviry='No';
          brandName.text = editProduct?.brandName??'';
          productName.text = editProduct?.productName??'';
          productPrice.text = editProduct?.price??'';
          productDesc.text = editProduct?.productDescription??'';
          productWeight.text = editProduct?.productWeight??'';
          editProduct?.localPickUp==true?1:0;
          fetchCategories(category: editProduct!.category);
          selectedStock = editProduct!.stock=='InStock'?'In Stock':editProduct!.stock=='LowStock'?'Out of Stock':editProduct!.stock;
          qtyCtrl.text = '${editProduct!.stockQuantity}';

          if(isDeliveryFee==true){
            editProduct!.shippingCharges?.forEach((action){
              print('object:::: city:=>${action.city} && rate:=>${action.rate}');
              addCityRate(city: action.city,rate: action.rate);
            });
            

          }
          else{
            addCityRate(city: '',rate: '');
          }

          if(editProduct!.productDimentions!=null || editProduct!.productDimentions!.isNotEmpty){
            List<String> dimensions = editProduct!.productDimentions!.split('x');
            if (dimensions.length == 3) {
              productDL.text = dimensions[0]; // '10'
              productDW.text = dimensions[1]; // '3'
              productDH.text = dimensions[2]; // '4'
            }
          }


          update();
        });
      }
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
      selectedFile.add(File(image.path)) ;
      editProduct!.productImages!.add(image.path);
      update();
    } else {
      print('No image selected.');
    }
  }


  Category? selectedCategory;
  List<Category> categoryList = [];
  CategoryModelResponse categoryModelResponse = CategoryModelResponse();
  fetchCategories({String? category}) async {
    await getCategoriesApi().then((value) {
      categoryModelResponse = value;
      if (value.data != null && category != null) {
        categoryList.addAll(value.data!);
        print('category==>$category');
        selectedCategory = value.data!.firstWhere((item) => item.name == category);
        print('category==>${selectedCategory!.name}');
        getCommissionAmount(productPrice: productPrice.text,commissionPercent: selectedCategory?.commission??0);
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



}

class CityRateTextFields{
  TextEditingController cityCtrl;
  TextEditingController rateCtrl;
  CityRateTextFields({required this.cityCtrl,required this.rateCtrl});
}