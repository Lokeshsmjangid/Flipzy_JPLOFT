import 'dart:developer';
import 'package:flipzy/controllers/all_products_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomsheet {
  static void show(BuildContext context,{void Function()? onTap1, void Function()? onTap2}) {
    showModalBottomSheet(
      context: context,isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      // barrierColor: AppColors.orangeColor.withOpacity(0.25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35.0),
        ),
      ),
      enableDrag: true,
      builder: (_) => FilterBottomsheetWidget(onTap1: onTap1, onTap2: onTap2, ),
    );
  }
}

class FilterBottomsheetWidget extends StatefulWidget {
  void Function()? onTap1;
  void Function()? onTap2;

  FilterBottomsheetWidget({this.onTap1, this.onTap2});

  @override
  State<FilterBottomsheetWidget> createState() => _FilterBottomsheetWidgetState();
}

class _FilterBottomsheetWidgetState extends State<FilterBottomsheetWidget> {

  final focusNode = FocusNode();
  AllProductsController ctrl = Get.find<AllProductsController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35)),
        child: SingleChildScrollView(
          child: Obx(() => Padding(
            padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addText700('Filter',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor
                      ),
                      child: Icon(Icons.close, size: 20,),
                    ),
                  )
                ],
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: addText700('Location',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),
              SizedBox(height: 10,),
              CustomTextField(
                  controller: ctrl.filterLocation,
                  hintText: 'Enter your location',
                  onChanged: (val){
                    ctrl.deBounce.run(() {
                      ctrl.getSuggestion(val);
                    });
                  },
                  suffixIcon: ctrl.filterLocation.text.isNotEmpty
                      ? IconButton(onPressed: (){
                    ctrl.filterLocation.clear();
                    ctrl.update();
                  }, icon: Icon(Icons.cancel_outlined))
                      : null),
              if(ctrl.placePredication.isNotEmpty)
                SizedBox(
                  height: 130,
                  child: ListView.separated(shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: ctrl.placePredication.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (){
                          showLoader(true);
                          ctrl.getAddressFromPlaceId(ctrl.placePredication[index].placeId.toString()).then((value) {
                            if(value.responseCode==200){
                              log('Manual address:${value.address}');
                              log('Manual description:${ctrl.placePredication[index].description}');
                              ctrl.filterLocation.text = "${value.city}";
                              ctrl.placePredication.clear();
                              ctrl.update();
                              log('Manual city:${value.city}');
                              log('Manual state:${value.state}');
                              log('Manual country:${value.country}');
                              log('Manual postalCode:${value.postalCode}');
                              log('Manual latitude:${value.latitude}');
                              log('Manual longitude:${value.longitude}');
                            }
                          });


                        },
                        contentPadding: EdgeInsets.symmetric(horizontal: 14),visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.male_rounded,color: AppColors.blackColor),
                            addWidth(5),
                            Expanded(child: addText400('${ctrl.placePredication[index].description}',fontSize: 14)),
                          ],
                        ),
                        // Add more widgets to display additional information as needed
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),


              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: addText700('Product Condition',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),

              ...ctrl.productConditionList.map((item) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: item.isSelect?.value ?? false,
                      /*onChanged: (val) {
                        item.isSelect?.value = val!;
                        item.isSelect?.refresh();
                        // contt.update();
                        // Get.to(const TherepySession());
                      },*/
                      onChanged: (val) {
                        if (val == true) {
                          // Unselect all items
                          for (var other in ctrl.productConditionList) {
                            other.isSelect?.value = false;
                          }
                          // Select current item
                          item.isSelect?.value = true;
                        } else {
                          // Allow deselecting the selected item (optional)
                          item.isSelect?.value = false;
                        }
                      },
                      activeColor: AppColors.greenColor, // Color of the checkbox when checked
                      checkColor: Colors.white,
                    ),
                     Expanded(
                      child: Text(
                        "${item.conditionVal}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: addText700('Price',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),

              buildRentSlider(ctrl.currentRangeValues),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: addText700('Sort By',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),

              ...ctrl.shortList.map((item) {return  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: item.isSelect?.value ?? false,
                      onChanged: (val) {
                        if (val == true) {
                          // Unselect all items
                          for (var other in ctrl.shortList) {
                            other.isSelect?.value = false;
                          }
                          // Select current item
                          item.isSelect?.value = true;
                        } else {
                          // Allow deselecting the selected item (optional)
                          item.isSelect?.value = false;
                        }
                      },
                      activeColor: AppColors.greenColor,// Color of the checkbox when checked
                      checkColor: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        "${item.shortVal}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                );}),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AppButton(
                  onButtonTap: widget.onTap1,
                  buttonText: 'Apply', buttonColor: AppColors.primaryColor , buttonTxtColor: AppColors.blackColor,),
              ),

              SizedBox(height: 10,),

              Align(
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                    onTap: widget.onTap2,
                    child: addText700('Clear all',fontFamily: 'Manrope',color: AppColors.greenColor,fontSize: 12)),
              ),

            ],
          ),
          ))
        ),
      ),
    );
  }
}

