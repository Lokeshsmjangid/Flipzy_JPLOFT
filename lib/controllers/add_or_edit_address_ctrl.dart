import 'package:flipzy/Api/api_models/address_response_model.dart';
import 'package:flipzy/controllers/get_all_address_ctrl.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddOrEditAddressCtrl extends GetxController {

  bool isEdit = false;
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController landMarkCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController postCodeCtrl = TextEditingController();
  double? picLat;
  double? picLang;
  AddressModel? addressDetail;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      isEdit = Get.arguments['is_edit'];
      addressDetail = Get.arguments['address_detail'];
      if(isEdit){
        addressCtrl.text = addressDetail?.address??'';
        landMarkCtrl.text = addressDetail?.landmark??'';
        cityCtrl.text = addressDetail?.city??'';
        stateCtrl.text = addressDetail?.state??'';
        countryCtrl.text = addressDetail?.country??'';
        postCodeCtrl.text = addressDetail?.zipcode??'';
        picLat = addressDetail?.lat??0.0;
        picLang = addressDetail?.long??0.0;


        flipzyPrint(message: 'addressCtrl---> ${addressCtrl.text}');
        flipzyPrint(message: 'landMarkCtrl---> ${landMarkCtrl.text}');
        flipzyPrint(message: 'cityCtrl---> ${cityCtrl.text}');
        flipzyPrint(message: 'stateCtrl---> ${stateCtrl.text}');
        flipzyPrint(message: 'countryCtrl---> ${countryCtrl.text}');
        flipzyPrint(message: 'postCodeCtrl---> ${postCodeCtrl.text}');
        flipzyPrint(message: 'picLat---> ${picLat}');
        flipzyPrint(message: 'picLang---> ${picLang}');
      }
    }
  }

  
}

