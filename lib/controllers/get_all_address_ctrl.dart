import 'package:flipzy/Api/api_models/address_response_model.dart';
import 'package:flipzy/Api/repos/get_all_address_repo.dart';
import 'package:get/get.dart';

class GetAllAddressCtrl extends GetxController {
  AddressResponseModel model = AddressResponseModel();
  List<AddressModel> addressList = [];
  bool isDataLoading = false;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllAddress();
  }

  fetchAllAddress() async{
    isDataLoading = true;
    await getAllAddressApi().then((value){
      model = value;
      isDataLoading = false;
      if(value.data!=null){
        addressList.addAll(value.data??[]);
      }
      update();
    });
  }

}

class ManageAddress{
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  double? lat;
  double? lang;
  ManageAddress({this.address,this.landmark,this.city,this.state,this.country,this.zipCode,this.lat,this.lang,});

}

