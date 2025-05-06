
import 'dart:developer';
import 'package:flipzy/controllers/add_or_edit_address_ctrl.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flipzy/controllers/edit_profile_controller.dart';
import 'package:flipzy/controllers/enable_location_controller.dart';
import 'package:flipzy/controllers/get_all_address_ctrl.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leadingIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,
                size: 14,),
              addText400("Back", color: AppColors.blackColor,
                  fontSize: 12,
                  fontFamily: 'Poppins'),
            ],
          ).marginOnly(left: 12),
        ),
        centerTitle: true,
        titleTxt: "Enter Your Location",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),
      body: GetBuilder<EnableLocationController>(
          init: EnableLocationController(),
          builder: (mlCtrl) {
        return Column(
          children: [
            addHeight(20),
            CustomTextField(
              // border: InputBorder.none,
              borderRadius: 100,
              controller: mlCtrl.searchCtrl,
              hintText: 'Search location here'.tr,
              filled: true,
              fillColor: AppColors.whiteColor,
              onChanged: (val){
                mlCtrl.deBounce.run(() {
                  mlCtrl.getSuggestion(val);
                });
              },
              prefixIcon: SvgPicture.asset(AppAssets.searchIcon).marginAll(12),
            ).marginSymmetric(horizontal: 20),
            addHeight(20),

            Divider(height: 2,color: AppColors.textColor3,),
            addHeight(10),

            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center ,
                  children: [
                    Icon(Icons.male_rounded,color: Colors.white,),
                    addWidth(5),
                    addText600('Use my Current Location',color: Colors.white,fontSize: 14)
                  ],

                ),
              ).marginSymmetric(horizontal: 20),
            ),
            addHeight(10),

            Divider(height: 2,color: AppColors.textColor3,),
            addHeight(10),

            if(mlCtrl.placePredication.isNotEmpty)
              Expanded(
                flex: 8,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: mlCtrl.placePredication.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){

                        showLoader(true);
                        mlCtrl.getAddressFromPlaceId(mlCtrl.placePredication[index].placeId.toString()).then((value) {
                          if(value.responseCode==200){
                            log('Manual address:${value.address}');
                            log('Manual description:${mlCtrl.placePredication[index].description}');
                            log('Manual city:${value.city}');
                            log('Manual state:${value.state}');
                            log('Manual country:${value.country}');
                            log('Manual postalCode:${value.postalCode}');
                            log('Manual latitude:${value.latitude}');
                            log('Manual longitude:${value.longitude}');

                            //
                            Get.find<CheckOutController>().latitude = value.latitude;
                            Get.find<CheckOutController>().longitude = value.longitude;
                            Get.find<CheckOutController>().shippingAddress = mlCtrl.placePredication[index].description.toString();
                            Get.find<CheckOutController>().city = value.city;
                            Get.find<CheckOutController>().state = value.state;
                            Get.find<CheckOutController>().country = value.country;
                            Get.find<CheckOutController>().postalCode = value.postalCode;
                            Get.find<CheckOutController>().update();

                            Get.find<AddOrEditAddressCtrl>().picLat = value.latitude;
                            Get.find<AddOrEditAddressCtrl>().picLang = value.longitude;
                            Get.find<AddOrEditAddressCtrl>().addressCtrl.text = mlCtrl.placePredication[index].description.toString();
                            Get.find<AddOrEditAddressCtrl>().cityCtrl.text = value.city;
                            Get.find<AddOrEditAddressCtrl>().stateCtrl.text = value.state;
                            Get.find<AddOrEditAddressCtrl>().countryCtrl.text = value.country;
                            Get.find<AddOrEditAddressCtrl>().postCodeCtrl.text = value.postalCode;
                            Get.find<AddOrEditAddressCtrl>().update();
                            Get.back();
                          }
                        });


                        // Get.find<EditProfileController>().streetCtrl.text = mlCtrl.placePredication[index].structuredFormatting!.mainText.toString();
                        //
                        // var length = mlCtrl.placePredication[index].terms!.length;
                        //
                        // for(var i =0;i<length;i++){
                        //
                        //   Get.find<EditProfileController>().cityCtrl.text = mlCtrl.placePredication[index].terms![length-3].value.toString();
                        //   Get.find<EditProfileController>().countryCtrl.text = mlCtrl.placePredication[index].terms![length-1].value.toString();
                        // }

                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 14),visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.male_rounded,color: AppColors.secondaryColor),
                          addWidth(5),
                          Expanded(child: addText400('${mlCtrl.placePredication[index].description}')),
                        ],
                      ),
                      // Add more widgets to display additional information as needed
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                ),
              ),
            addHeight(20),

          ],
        );
      }),
    );}}
