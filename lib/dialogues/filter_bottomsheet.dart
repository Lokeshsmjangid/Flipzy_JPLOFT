import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FilterBottomsheet {
  static void show(BuildContext context,{void Function()? onTap1, void Function()? onTap2}) {
    showModalBottomSheet(
      context: context,
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

class FilterBottomsheetWidget extends StatelessWidget {
  void Function()? onTap1;
  void Function()? onTap2;

  FilterBottomsheetWidget({this.onTap1, this.onTap2});

  RxBool isNew = false.obs;
  RxBool isRefurbished = false.obs;
  RxBool isOld = false.obs;

  RxList<ProductCondition> productConditionList = <ProductCondition>[
    ProductCondition(conditionVal: "New".obs, isSelect: false.obs),
    ProductCondition(conditionVal: "Refurbished".obs, isSelect: false.obs),
    ProductCondition(conditionVal: "Old".obs, isSelect: false.obs),
  ].obs ;

  RxList<Location> locationList = <Location>[
    Location(countryVal: "Sounth Africa".obs, isSelect: false.obs),
    Location(countryVal: "India".obs, isSelect: false.obs),
    Location(countryVal: "U.S.S".obs, isSelect: false.obs),
  ].obs ;

  Rx<RangeValues> currentRangeValues = const RangeValues(1, 5000).obs;

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
                child: addText700('Product Condition',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),

              ...productConditionList.map((item) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: item.isSelect?.value ?? false,
                      onChanged: (val) {
                        item.isSelect?.value = val!;
                        item.isSelect?.refresh();
                        // contt.update();
                        // Get.to(const TherepySession());
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

              buildRentSlider(currentRangeValues),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: addText700('Location',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 12),
              ),

              ...locationList.map((item) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: item.isSelect?.value ?? false,
                      onChanged: (val) {
                        item.isSelect?.value = val!;
                        item.isSelect?.refresh();
                        // contt.update();
                        // Get.to(const TherepySession());
                      },
                      activeColor: AppColors.greenColor,// Color of the checkbox when checked
                      checkColor: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        "${item.countryVal}",
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AppButton(
                  onButtonTap: onTap1,
                  buttonText: 'Apply', buttonColor: AppColors.primaryColor , buttonTxtColor: AppColors.blackColor,),
              ),

              SizedBox(height: 10,),

              Align(
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                    onTap: onTap2,
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

class ProductCondition {
  RxString? conditionVal = "".obs ;
  RxBool? isSelect = false.obs;

  ProductCondition({this.conditionVal , this.isSelect});
}

class Location {
  RxString? countryVal = "".obs ;
  RxBool? isSelect = false.obs;

  Location({this.countryVal , this.isSelect});

}

buildRentSlider(Rx<RangeValues>  rangeVal) {

  return Obx(() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: 20,),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: addText500('1')),
              addText500('5000+'),
            ],
          ),
          RangeSlider(
            values: rangeVal.value,
            min: 1,
            max: 5000,
            divisions: 1000,

            labels: RangeLabels(
              '\$${rangeVal.value.start.round()}',
              '\$${rangeVal.value.end.round()}',
            ),
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.greyColor,
            onChanged: (RangeValues values) {
              rangeVal.value = values;
            },
          ),
          addHeight(10),

          /*addText500('${'Selected Range'.tr}: \$${rangeVal.value.start
              .round()} - \$${rangeVal.value.end
              .round()}'),*/

          // BaseText(
          //   value: '${'Selected Range'.tr}: \$${controller.currentRangeValues.value.start
          //       .round()} - \$${controller.currentRangeValues.value.end
          //       .round()}',
          //   fontSize: 16, fontWeight: FontWeight.w500,
          // ),

        ],
      ),
    );
  });
}