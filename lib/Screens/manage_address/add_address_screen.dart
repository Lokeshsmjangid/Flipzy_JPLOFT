import 'package:flipzy/Api/repos/add_address_repo.dart';
import 'package:flipzy/Screens/location_screen/manual_location.dart';
import 'package:flipzy/controllers/add_or_edit_address_ctrl.dart';
import 'package:flipzy/controllers/get_all_address_ctrl.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leadingIcon: IconButton(
            onPressed: (){
              Get.back();},
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "Saved Address",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,

        
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddOrEditAddressCtrl>(builder: (logic) {
          return Column(
            children: [
              addHeight(12),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('Address',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.addressCtrl,
              hintText: 'Address',
                onTap: (){
                Get.to(()=>ManualLocation());
                },
          ),
              addHeight(10),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('Landmark',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.landMarkCtrl,
              hintText: 'Enter your landmark',
          ),
              addHeight(10),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('City',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.cityCtrl,
              hintText: 'Enter City',
          ),
              addHeight(10),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('State',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.stateCtrl,
              hintText: 'Enter State',
          ),
              addHeight(10),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('Country',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.countryCtrl,
              hintText: 'Enter Country',
          ),
              addHeight(10),

              Align(
                  alignment: Alignment.centerLeft,
                  child: addText500('Zip Code',fontSize: 16).marginOnly(bottom: 8)),
              CustomTextField(
                controller: logic.postCodeCtrl,
              hintText: 'Enter your Zip Code',
          ),
              addHeight(30),
              
              AppButton(buttonText: logic.isEdit?'Update':'Save',onButtonTap: (){

                if(logic.isEdit){
                  showLoader(true);
                  addAddressApi(
                      isEdit: true,
                      addressId: logic.addressDetail?.id,
                      address: logic.addressCtrl.text,
                      landmark: logic.landMarkCtrl.text,
                      city: logic.cityCtrl.text,
                      state: logic.stateCtrl.text,
                      country: logic.countryCtrl.text,
                      zipCode: logic.postCodeCtrl.text,
                      lat: logic.picLat,
                      lang: logic.picLang
                  ).then((val){
                    showLoader(false);
                    if(val.status==true){
                      Get.find<GetAllAddressCtrl>().addressList.clear();
                      Get.find<GetAllAddressCtrl>().onInit();
                      Get.find<GetAllAddressCtrl>().update();
                      Get.back();
                    }
                  });
                }else{
                  showLoader(true);
                  addAddressApi(
                    isEdit: false,
                      address: logic.addressCtrl.text,
                      landmark: logic.landMarkCtrl.text,
                      city: logic.cityCtrl.text,
                      state: logic.stateCtrl.text,
                      country: logic.countryCtrl.text,
                      zipCode: logic.postCodeCtrl.text,
                      lat: logic.picLat,
                      lang: logic.picLang
                  ).then((val){
                    showLoader(false);
                    if(val.status==true){
                      Get.find<GetAllAddressCtrl>().addressList.clear();
                      Get.find<GetAllAddressCtrl>().onInit();
                      Get.find<GetAllAddressCtrl>().update();
                      Get.back();
                    }
                  });
                }


              },),

              addHeight(30),
            ],
          ).marginSymmetric(horizontal: 20);
        }),
      ),
    );
  }
}
