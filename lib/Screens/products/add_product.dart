import 'dart:developer';
import 'dart:io';
import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/repos/add_product_repo.dart';
import 'package:flipzy/Screens/help/help_support.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_dropdown.dart';
import '../product_management.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});

  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
        init: AddProductController(),
        builder: (contt) {
          return Scaffold(
            backgroundColor: Color(0xffeff2eb),
            appBar: customAppBar(
              backgroundColor: AppColors.bgColor,
              leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
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
              titleTxt: "Add Product",
              titleColor: AppColors.blackColor,
              titleFontSize: 16,
              bottomLine: false,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      //AddImageGrid
                      addHeight(10),
                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Color(0xffeef2ed),
                            borderRadius: BorderRadius.circular(26)

                        ),
                        child: Column(
                          children: [
                            // if(contt.selectedFile.isNotEmpty)
                              contt.selectedFile.isNotEmpty
                                  ? GridView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.95, // Adjust height ratio
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                itemCount: contt.selectedFile.length??0,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Image.file(File(contt.selectedFile[index]!.path)), // ✅ Correct widget
                                          /*child: SvgPicture.asset(
                                      AppAssets.addImageImg,
                                      color: AppColors.greyColor,
                                      fit: BoxFit.contain,

                                      // width: 21,
                                      // height: 20,
                                                                      ),*/
                                        ),
                                      ),

                                      Positioned(
                                          right: 4,
                                          top:10,
                                          child: GestureDetector(
                                              onTap: (){
                                                contt.selectedFile.removeAt(index);

                                                contt.update();
                                              },
                                              child: Icon(Icons.cancel,color: AppColors.armyGreenColor,)))
                                    ],
                                  );
                                },
                              )
                                  : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.95, // Adjust height ratio
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      // child: Image.file(File(contt.selectedFile[index]!.path)), // ✅ Correct widget
                                      child: SvgPicture.asset(
                                        AppAssets.addImageImg,
                                        color: AppColors.greyColor,
                                        fit: BoxFit.contain,

                                        // width: 21,
                                        // height: 20,
                                      ),
                                    ),
                                  );
                                },
                              ),


                            SizedBox(height: 20,),
                            //AddButton
                            GestureDetector(
                              onTap: () {
                                contt.showCameraGalleryDialog(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  // border: Border.all(
                                  //   color: AppColors.orangeColor,
                                  //   width: 1.5,
                                  // ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.addIC,
                                  color: AppColors.blackColor,
                                  fit: BoxFit.contain,
                                  // width: 21,
                                  // height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 10,),
                      //BrandName
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Brand Name", textAlign: TextAlign.start,
                              fontFamily: 'Manrope')
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: contt.brandName,
                        fillColor: AppColors.whiteColor,
                        hintText: "Enter Brand Name",
                        validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ),

                      SizedBox(height: 10,),
                      //ProductName
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500(
                              "Product Name", textAlign: TextAlign.start,
                              fontFamily: 'Manrope')
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: contt.productName,
                        fillColor: AppColors.whiteColor,
                        hintText: "Enter Product Name",
                        validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ),


                      //Product Condition
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText500("Product Condition", textAlign: TextAlign.start,
                              fontFamily: 'Manrope')
                      ),

                      SizedBox(height: 10,),
                      CustomDropdownButton2<String>(
                        hintText: "Choose Product Condition",
                        items: contt.conditionList ?? [],
                        value: contt.selectedProductCondition,
                        displayText: (item) => "${item}",
                        onChanged: (value) {
                          contt.selectedProductCondition = value;
                          contt.update();
                        },
                        borderRadius: 10,
                      ),

                      //Category
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600("Category", textAlign: TextAlign.start,
                              fontFamily: 'Manrope')
                      ),

                      SizedBox(height: 10,),
                      CustomDropdownButton2<Category>(
                        hintText: "Choose Category",
                        items: contt.categoryList ?? [],
                        value: contt.selectedCategory,
                        displayText: (item) => "${item.name}",
                        onChanged: (value) {
                          contt.selectedCategory = value;
                          contt.getCommissionAmount(
                              productPrice: contt.productPrice.text.isNotEmpty?contt.productPrice.text:'0',
                              commissionPercent: contt.selectedCategory!.commission!);
                          contt.update();
                        },
                        borderRadius: 10,
                      ),


                      //Price
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600("Price", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: contt.productPrice,
                        fillColor: AppColors.whiteColor,
                        hintText: "Enter Price",
                        validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                        keyboardType: TextInputType.number,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onChanged: (value){
                          if(value.isNotEmpty)
                            contt.deBounce.run((){
                              contt.getCommissionAmount(productPrice: value,commissionPercent: contt.selectedCategory!=null?contt.selectedCategory!.commission! : 0);
                              contt.update();
                            });
                        },

                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText400(
                              "You will get ₦${contt.amountAfterDeduction??0.0} for this",
                              textAlign: TextAlign.start,fontFamily: '',
                              color: AppColors.greyColor)
                      ),

                      //Description
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600("Description", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: contt.productDesc,
                        fillColor: AppColors.whiteColor,
                        hintText: "Enter Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        maxLines: 5,
                      ),


                      // //Pick Up Location
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600(
                              "Pick Up Location", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                          controller: contt.pickUpLocation,
                          hintText: 'Enter your location',
                          filled: true,
                          fillColor: Colors.white,
                          onChanged: (val){
                            contt.deBounce.run(() {
                              contt.getSuggestion(val);
                            });
                          },
                          suffixIcon: contt.pickUpLocation.text.isNotEmpty
                              ? IconButton(onPressed: (){
                            contt.pickUpLocation.clear();
                            contt.update();
                          }, icon: Icon(Icons.cancel_outlined))
                              : null),
                      if(contt.placePredication.isNotEmpty)
                        SizedBox(
                          height: 200,
                          child: ListView.separated(shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: contt.placePredication.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: (){
                                  showLoader(true);
                                  contt.getAddressFromPlaceId(contt.placePredication[index].placeId.toString()).then((value) {
                                    if(value.responseCode==200){
                                      log('Manual address:${value.address}');
                                      log('Manual description:${contt.placePredication[index].description}');
                                      contt.pickUpLocation.text = "${contt.placePredication[index].description}";
                                      contt.placePredication.clear();
                                      contt.update();
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
                                    Expanded(child: addText400('${contt.placePredication[index].description}',fontSize: 14)),
                                  ],
                                ),
                                // Add more widgets to display additional information as needed
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ),

                      //ProductWeight
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600(
                              "Product Weight (in gms)", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),

                      CustomTextField(
                        controller: contt.productWeight,
                        fillColor: AppColors.whiteColor,
                        hintText: "Enter Product Weight",
                        keyboardType: TextInputType.number,
                        validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ),

                      //ProductDimension
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600(
                              "Product Dimension", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: contt.productDL,
                              fillColor: AppColors.whiteColor,
                              hintText: "Length",
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: CustomTextField(
                              controller: contt.productDW,
                              fillColor: AppColors.whiteColor,
                              hintText: "Width",
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: CustomTextField(
                              controller: contt.productDH,
                              fillColor: AppColors.whiteColor,
                              hintText: "Height",
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),

                            ),
                          ),
                        ],
                      ),
//LocalPicup
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              addText600("Local Pickup", textAlign: TextAlign.start),
                              addWidth(10),
                              GestureDetector(
                                onTap: () {
                                  // contt.isLocalPickup = !contt.isLocalPickup;
                                  if(!contt.isLocalPickup)
                                    contt.isLocalPickup = true;
                                  // if(contt.isLocalPickup){
                                  contt.isDeliveryFee = false;
                                  contt.isBeyondCity = false;
                                  contt.selectedDeliviry=null;
                                  contt.cityRates.clear();
                                  // }
                                  contt.update();
                                },
                                child: Container(
                                  width: 40,
                                  height: 20,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor, // Border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded rectangle
                                  ),
                                  child: Row(
                                    mainAxisAlignment: contt.isLocalPickup == true
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if(contt.isLocalPickup == true)
                                        Image.asset(AppAssets.toggleGreenIc),
                                      if(contt.isLocalPickup == false)
                                        Image.asset(AppAssets.toggleGreyIc),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      /* SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGreyColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            contt.enableDisableBtn = 1;
                            contt.update();
                          },
                          child: SvgPicture.asset(
                            contt.enableDisableBtn == 1
                                ? AppAssets.enableRadioIC
                                : AppAssets.disableRadioIC,
                            // color: AppColors.whiteColor,
                            fit: BoxFit.contain,
                            width: 21,
                            height: 20,
                          ),
                        ),
                        addWidth(4),
                        addText600("Enable", textAlign: TextAlign.start,
                            color: AppColors.greyColor),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () {
                            contt.enableDisableBtn = 0;
                            contt.update();
                          },
                          child: SvgPicture.asset(
                            contt.enableDisableBtn == 0
                                ? AppAssets.enableRadioIC
                                : AppAssets.disableRadioIC,
                            // color: AppColors.whiteColor,
                            fit: BoxFit.contain,
                            width: 21,
                            height: 20,
                          ),
                        ),
                        addWidth(4),
                        addText600("Disable", textAlign: TextAlign.start,
                            color: AppColors.greyColor)
                      ],
                    ),
                  ),*/

                      SizedBox(height: 10,),
                      richText2(
                          text1: 'Not sure how to measure product? Visit our',
                          fontSize: 14,
                          fontWeight1: FontWeight.w500,
                          fontWeight2: FontWeight.w600,
                          text2: ' FAQs page',
                          textAlign: TextAlign.left,
                          textColor2: Color(0xff738046)),
                      SizedBox(height: 10,),


                      // Delivery Fees
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              addText600("Delivery Fees", textAlign: TextAlign.start),
                              addWidth(10),
                              GestureDetector(
                                onTap: () {
                                  if(!contt.isDeliveryFee)
                                    contt.isDeliveryFee = true;
                                  // contt.isDeliveryFee = !contt.isDeliveryFee;
                                  if(contt.isDeliveryFee){ // check selected toggle
                                    if(contt.cityRates.length==0){
                                      contt.addCityRate();
                                      contt.isLocalPickup = false;

                                      contt.isBeyondCity = false;
                                      contt.selectedDeliviry=null;
                                    } else{
                                      contt.isLocalPickup = false;

                                      contt.isBeyondCity = false;
                                      contt.selectedDeliviry=null;
                                    }
                                  }
                                  contt.update();
                                },
                                child: Container(
                                  width: 40,
                                  height: 20,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor, // Border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded rectangle
                                  ),
                                  child: Row(
                                    mainAxisAlignment: contt.isDeliveryFee == true
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if(contt.isDeliveryFee == true)
                                        Image.asset(AppAssets.toggleGreenIc),
                                      if(contt.isDeliveryFee == false)
                                        Image.asset(AppAssets.toggleGreyIc),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),


                      if(contt.isDeliveryFee)
                        Align(
                            alignment: Alignment.centerLeft,
                            child: addText400(
                                "(With in city)", textAlign: TextAlign.start,
                                color: AppColors.greyColor)
                        ),
                      if(contt.isDeliveryFee)
                        SizedBox(height: 10,),
                      if(contt.isDeliveryFee)
                        Column(
                          children: [
                            ...List.generate(contt.cityRates.length, (index) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Row(

                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextField(
                                          fillColor: AppColors.whiteColor,
                                          controller: contt.cityRates[index].cityCtrl,
                                          hintText: "City ${index + 1}",
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                          onChanged: (value) {
                                            // contt.updateCityRate(index, value, "city");
                                          },
                                        ),
                                      ),
                                      addWidth(16),
                                      Expanded(
                                        flex: 3,
                                        child: CustomTextField(
                                          fillColor: AppColors.whiteColor,
                                          hintText: "Rate",
                                          controller: contt.cityRates[index].rateCtrl,
                                          keyboardType: TextInputType.number,
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                          // onChanged: (value) {
                                          //   contt.updateCityRate(index, value, "rate");
                                          // },
                                        ),
                                      ),

                                    ],
                                  ).marginOnly(bottom: 14),

                                  if(index !=0)
                                    Positioned(
                                        right: 0,
                                        top: -10,
                                        child: GestureDetector(
                                            onTap: (){
                                              contt.cityRates.removeAt(index);
                                              contt.update();
                                              print('object ddff ${index}');
                                            },
                                            child: Icon(Icons.cancel,color: Colors.red,)))
                                ],
                              );
                            }),

                            // Add More Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  contt.addCityRate();
                                },
                                child: addText500('Add More', fontSize: 12, decoration: TextDecoration.underline, color: Color(0xff738046)),
                              ),
                            ),
                          ],
                        ),


                      //SellBeyondCity
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              addText600("Looking to sell beyond the city limits?",
                                  textAlign: TextAlign.start),
                              addWidth(10),
                              GestureDetector(
                                onTap: () {
                                  if(!contt.isBeyondCity)
                                    contt.isBeyondCity = true;
                                  // contt.isDeliveryFee = !contt.isDeliveryFee;
                                  contt.isLocalPickup = false;
                                  contt.isDeliveryFee = false;
                                  contt.cityRates.clear();
                                  contt.update();
                                },
                                child: Container(
                                  width: 40,
                                  height: 20,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor, // Border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded rectangle
                                  ),
                                  child: Row(
                                    mainAxisAlignment: contt.isBeyondCity == true
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if(contt.isBeyondCity == true)
                                        Image.asset(AppAssets.toggleGreenIc),
                                      if(contt.isBeyondCity == false)
                                        Image.asset(AppAssets.toggleGreyIc),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      if(contt.isBeyondCity)
                        SizedBox(height: 10,),
                      if(contt.isBeyondCity)
                        CustomDropdownButton2(
                          hintText: "Choose Our Delivery",
                          items: contt.deliveryList ?? [],
                          value: contt.selectedDeliviry,
                          displayText: (item) => "$item",
                          onChanged: (value) {
                            contt.selectedDeliviry = value.toString();
                            contt.update();
                          },
                          borderRadius: 10,
                        ),

                      //Stoke
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: addText600("Stock", textAlign: TextAlign.start)
                      ),

                      SizedBox(height: 10,),
                      CustomDropdownButton2(
                        hintText: "In Stock",
                        items: contt.stokeList ?? [],
                        value: contt.selectedStock,
                        displayText: (item) => "$item",
                        onChanged: (value) {
                          contt.selectedStock = value.toString();
                          contt.update();
                        },
                        borderRadius: 10,
                      ),


                      if(contt.selectedStock=='In Stock')
                        Align(
                            alignment: Alignment.centerLeft,
                            child: addText600("Quantity", textAlign: TextAlign.start)
                        ),
                      if(contt.selectedStock=='In Stock')
                        SizedBox(height: 10,),
                      if(contt.selectedStock=='In Stock')
                        CustomTextField(
                          controller: contt.qtyCtrl,
                          fillColor: AppColors.whiteColor,
                          hintText: "Enter Quantity",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: MultiValidator([RequiredValidator(errorText: 'This field is required.')]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),

                        ),


                      SizedBox(height: 16,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              addText600("Is Return Available", textAlign: TextAlign.start),
                              addWidth(10),
                              GestureDetector(
                                onTap: () {
                                  contt.isReturnAvailable = !contt.isReturnAvailable;
                                  contt.update();

                                  log('isReturnAvailable---->${contt.isReturnAvailable} ');
                                },
                                child: Container(
                                  width: 40,
                                  height: 20,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor, // Border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded rectangle
                                  ),
                                  child: Row(
                                    mainAxisAlignment: contt.isReturnAvailable == true
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if(contt.isReturnAvailable == true)
                                        Image.asset(AppAssets.toggleGreenIc),
                                      if(contt.isReturnAvailable == false)
                                        Image.asset(AppAssets.toggleGreyIc),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(height: 20,),
                      //AddButton
                      GestureDetector(
                        onTap: () {
                          if(formKey.currentState?.validate()??false){

                            if(contt.qtyCtrl.text =='0'){
                              showToastError('Quantity should be more than 0');

                            }
                            else if(contt.enableDisableBtn==0 && (contt.cityRates[0].cityCtrl.text=='' || contt.cityRates[0].rateCtrl.text=='')){
                              showToastError('City & Rate fields are required');
                            }
                            else{
                              print('object::::${contt.enableDisableBtn}');
                              showLoader(true);
                              addProductApi(
                                brandName: contt.brandName.text,
                                productName: contt.productName.text,
                                productCondition: contt.selectedProductCondition,
                                pickupLocation: contt.pickUpLocation.text,
                                catagory: contt.selectedCategory!.name,
                                price: contt.productPrice.text,
                                commission: contt.commissionAmount.toString(),
                                amountAfterDeduction: contt.amountAfterDeduction.toString(),
                                productDescription: contt.productDesc.text,
                                productWeight: '${contt.productWeight.text}',
                                productDimentions: '${contt.productDL.text}x${contt.productDW.text}x${contt.productDH.text}',
                                localPickUp: contt.isLocalPickup.toString(),
                                isReturnAvailable: contt.isReturnAvailable.toString(),
                                deliveryFee: contt.isDeliveryFee.toString(),
                                delivery: contt.isDeliveryFee==false?null:contt.cityRates,
                                sellBeyondCityLimits: contt.selectedDeliviry??'No',
                                stock: contt.selectedStock,
                                stockQuantity: contt.selectedStock =='In Stock' ? contt.qtyCtrl.text=='0'?"1":contt.qtyCtrl.text : '1',
                                productImages: contt.selectedFile.isNotEmpty?contt.selectedFile.whereType<File>().toList():[],
                              ).then((value){
                                showLoader(false);
                                if(value.status==true){
                                  contt.brandName.clear();
                                  contt.productName.clear();
                                  contt.productPrice.clear();
                                  contt.productDesc.clear();
                                  contt.productWeight.clear();
                                  contt.productDL.clear();
                                  contt.productDW.clear();
                                  contt.productDH.clear();
                                  contt.pickUpLocation.clear();
                                  contt.selectedFile=[];
                                  contt.isReturnAvailable=false;
                                  contt.selectedCategory=null;
                                  contt.selectedProductCondition = null;
                                  contt.selectedDeliviry=null;
                                  contt.selectedStock =null;
                                  contt.qtyCtrl.text=='0';
                                  contt.cityRates.clear();
                                  contt.addCityRate();

                                  Get.back();
                                };
                              });
                            }
                          }


                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            // border: Border.all(
                            //   color: AppColors.orangeColor,
                            //   width: 1.5,
                            // ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: addText700("Add", textAlign: TextAlign.start,
                              color: AppColors.blackColor),
                        ),
                      ),

                      SizedBox(height: 10,),

                      GestureDetector(
                        onTap: () {
                          Get.to(()=>HelpSupport());
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Text(
                            'Need Help',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              // Adds an underline
                              fontSize: 13,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                    ],
                  ).marginSymmetric(horizontal: 16),
                ),
              ),
            ),
          );
        }
    );
  }
}
