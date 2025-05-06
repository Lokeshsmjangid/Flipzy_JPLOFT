import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flipzy/Api/api_models/category_model.dart';
import 'package:flipzy/Api/repos/add_product_repo.dart';
import 'package:flipzy/Api/repos/add_seller_repo.dart';
import 'package:flipzy/Screens/help/help_support.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/product_management.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/controllers/complete_seller_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/custom_widgets/custom_dropdown.dart';
import 'package:flipzy/dialogues/seller_product_ready_dialogue.dart';
import 'package:flipzy/dialogues/upload_product_sucess_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class CompleteSellerInfo extends StatefulWidget {
  String fromScreen;

  CompleteSellerInfo({super.key, this.fromScreen = ""});

  @override
  State<CompleteSellerInfo> createState() => _CompleteSellerInfoState();
}

class _CompleteSellerInfoState extends State<CompleteSellerInfo> {
  RxBool isAgree = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthData().getLoginData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: AuthData().userModel!.userType!.toLowerCase() != 'user'
          ? GetBuilder<AddProductController>(
          init: AddProductController(),
          builder: (contt) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  addText700('Add Product',fontFamily: 'Manrope',fontSize: 16),
                  addHeight(20),
                  Divider(height: 0),
                  SizedBox(height: 10,),
                  //AddImageGrid
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(26)

                    ),
                    child: Column(
                      children: [
                        contt.selectedFile.isNotEmpty
                            ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                              clipBehavior: Clip.none,
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
                      child: addText600("Stoke", textAlign: TextAlign.start)
                  ),



                  SizedBox(height: 10,),
                  CustomDropdownButton2(
                    hintText: "Choose Stock",
                    items: contt.stokeList ?? [],
                    value: contt.selectedStock,
                    displayText: (item) => "$item",
                    onChanged: (value) {
                      contt.selectedStock = value.toString();
                      contt.update();
                    },
                    borderRadius: 10,
                  ),


                  SizedBox(height: 10,),

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

                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  //AddButton
                  GestureDetector(
                    onTap: () {
                      if(formKey.currentState?.validate()??false){
                        // contt.printValues();
                        if(contt.qtyCtrl.text=='0'){
                          showToastError('Quantity should be more than 0');
                        } else if(contt.isDeliveryFee==true && (contt.cityRates[0].cityCtrl.text.isEmpty || contt.cityRates[0].rateCtrl.text.isEmpty)){
                          showToastError('City & Rate fields are required');
                        }else{


                          showLoader(true);
                          addProductApi(
                            brandName: contt.brandName.text,
                            productName: contt.productName.text,
                            catagory: contt.selectedCategory!.name,
                            price: contt.productPrice.text,
                            commission: contt.commissionAmount.toString(),
                            amountAfterDeduction: contt.amountAfterDeduction.toString(),
                            productDescription: contt.productDesc.text,
                            productWeight: '${contt.productWeight.text}',
                            productDimentions: '${contt.productDL.text}x${contt.productDW.text}x${contt.productDH.text}',
                            localPickUp: contt.isLocalPickup.toString(),
                            deliveryFee: contt.isDeliveryFee.toString(),
                            delivery: contt.isDeliveryFee==false?null:contt.cityRates,
                            // deliveryRate:contt.enableDisableBtn==1?null:contt.cityRates,
                            sellBeyondCityLimits: contt.selectedDeliviry??'No',
                            stock: contt.selectedStock,
                            stockQuantity: contt.selectedStock =='In Stock' ? contt.qtyCtrl.text=='0'?"1":contt.qtyCtrl.text : '1',
                            productImages: contt.selectedFile.isNotEmpty?contt.selectedFile.whereType<File>() // ✅ removes nulls
                                .toList():[],
                            isReturnAvailable: contt.isReturnAvailable.toString(),
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
                              contt.selectedFile=[];
                              contt.selectedDeliviry=null;
                              contt.selectedCategory=null;
                              contt.selectedStock =null;
                              contt.isReturnAvailable = false;
                              contt.qtyCtrl.text=='0';

                              contt.cityRates.clear();

                              print("contt.cityRates adad ");
                              print(contt.cityRates);


                              contt.addCityRate();
                              print("contt.cityRates");
                              print(contt.cityRates);
                              // contt.updateCityRate(0, '', "city");
                              // contt.updateCityRate(0, '', "rate");
                              contt.getCommissionAmount(productPrice: '0',commissionPercent: 0);
                              contt.update();

                              UploadProductSucessDialog.show(
                                  context,
                                  onTap: (){
                                Future.microtask(() {
                                  Get.back();
                                  Get.toNamed(AppRoutes.myProductsScreen);
                                });
                              }
                              );};
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
                    onTap: () {Get.to(()=>HelpSupport());},
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
        );
      })
          : GetBuilder<CompleteSellerController>(
          init: CompleteSellerController(),
          builder: (contt) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  children: [

                    Visibility(
                        visible: widget.fromScreen == "DashBoard" ? true : false,
                        child: SizedBox(height: 30,)
                    ),

                    Visibility(
                        visible: widget.fromScreen == "DashBoard" ? true : false,
                        child: Align(
                          alignment: Alignment.center,
                          child: addText700(
                              "Complete Seller Info", fontSize: 22),
                        )
                    ),

                    SizedBox(height: 30,),
                    //UploadImage
                    GestureDetector(
                      onTap: () {
                        contt.showCameraGalleryDialog(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if(contt.selectedFile.isNotEmpty)
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Image.file(File(contt.selectedFile[0]!.path.toString()),fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 0.18,
                                    width: MediaQuery.of(context).size.width * 0.40,)),

                            if(contt.selectedFile.isEmpty && AuthData().userModel?.profileImage !='')
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: CachedImageCircle2(isCircular: true,
                                    imageUrl: '${AuthData().userModel!.profileImage}',
                                    fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 0.18,
                                    width: MediaQuery.of(context).size.width * 0.40,)),


                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: SvgPicture.asset(
                                  AppAssets.uploadPPImg,

                                  fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                                ).marginAll(40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Store/Business
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Store/Business Name",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      controller: contt.businessName,
                      hintText: "Enter your Store or business name",
                      keyboardType: TextInputType.name,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.storeIc,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius
                          .circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Name is required')
                      ]),

                    ),

                    //StoreDescription
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Store Description",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      controller: contt.businessDesc,
                      hintText: "Describe your store in few words",
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.storeIc,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius
                          .circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Description is required')
                      ]),
                    ),

                    //EmailAddress
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Email Address",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      controller: contt.businessEmail,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email",
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.mailIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius
                          .circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required'),
                        EmailValidator(errorText: 'Please enter valid email')
                      ]),

                    ),
                    //PhoneNum
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Phone Number",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      hintText: "Enter a valid phone number",
                      controller: contt.businessPhone,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.callIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only numbers allowed
                        LengthLimitingTextInputFormatter(15),  // Limits input to 15 digits
                      ],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Phone number is required'),
                        MinLengthValidator(6, errorText: 'Phone number must be at least 6 digits'),
                        MaxLengthValidator(15, errorText: 'Phone number must not exceed 15 digits')
                      ]),

                    ),

                    //AccHolder
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Account Holder Name",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      hintText: "Enter name",
                      controller: contt.businessAH,
                      keyboardType: TextInputType.name,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.personIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius
                          .circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Name is required')
                      ]),

                    ),

                    //BankName
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Bank Name",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      hintText: "Enter bank name",
                      controller: contt.businessBN,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.characters,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.bankBuildingIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Bank name is required')
                      ]),

                    ),

                    //ACCNumber
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Account Number",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      controller: contt.businessAN,
                      hintText: "Enter your bank account number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.bankBuildingIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius
                          .circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Account number is required')
                      ]),
                    ),

                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Account IFSC",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),

                    CustomTextField(
                      fillColor: AppColors.whiteColor,
                      controller: contt.businessIFSC,
                      hintText: "Enter your bank IFSC",
                      textCapitalization: TextCapitalization.characters,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: SvgPicture.asset(
                          AppAssets.bankBuildingIC,
                          // color: AppColors.greyColor,
                          fit: BoxFit.contain,
                          // width: 21,
                          // height: 20,
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'IFSC is required')
                      ]),
                    ),

                    SizedBox(height: 15,),
                    //AreYouBusiness
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Are You a Business",
                            textAlign: TextAlign.start)
                    ),

                    SizedBox(height: 5,),
                    //ToggleBtn

                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          contt.isBusiness = !contt.isBusiness;
                          contt.update();
                        },
                        child: Container(
                          width: 55,
                          height: 30,
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
                            mainAxisAlignment: contt.isBusiness == true
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if(contt.isBusiness == true)
                                Image.asset(AppAssets.toggleGreenIc),
                              if(contt.isBusiness == false)
                                Image.asset(AppAssets.toggleGreyIc),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //RCNumber
                    Visibility(
                        visible: contt.isBusiness,
                        child: SizedBox(height: 15,)),
                    Visibility(
                      visible: contt.isBusiness,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: addText600(
                              "RC Number", textAlign: TextAlign.start)
                      ),
                    ),

                    SizedBox(height: 5,),

                    Visibility(
                      visible: contt.isBusiness,
                      child: CustomTextField(
                        fillColor: AppColors.whiteColor,
                        controller: contt.businessRC,
                        hintText: "RC number",
                        prefixIcon: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: SvgPicture.asset(
                            AppAssets.bankBuildingIC,
                            // color: AppColors.greyColor,
                            fit: BoxFit.contain,
                            // width: 21,
                            // height: 20,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'RC number is required')
                        ]),

                      ),
                    ),

                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() =>
                            GestureDetector(
                              onTap: () {
                                isAgree.value = !isAgree.value;
                              },
                              child: Container(
                                height: 20, width: 20,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.primaryColor, width: 2)
                                ),
                                child: isAgree.value ? Image.asset(
                                    AppAssets.checkIC) : IgnorePointer(),
                              ),
                            ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: addText500(
                              "\"By creating a Seller Account, I agree to the Terms & Conditions of Flipzy.\"",
                              fontSize: 12),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    //AddButton
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          if(isAgree.value==true){
                            showLoader(true);
                            addSellerApi(
                                businessName: contt.businessName.text,
                                storeDescription: contt.businessDesc.text,
                                email: contt.businessEmail.text,
                                mobileNumber: contt.businessPhone.text,
                                accountHolderName: contt.businessAH.text,
                                bankName: contt.businessBN.text,
                                accountNumber: contt.businessAN.text,
                                businessCheck: contt.isBusiness,
                                rcNumber: contt.businessRC.text,
                                ifsc: contt.businessIFSC.text,
                                image: contt.selectedFile.isNotEmpty?contt.selectedFile[0]:null
                            ).then((value) {
                              showLoader(false);
                              if (value.status == true) {
                                LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                                AuthData().getLoginData();
                                SellerProductReadyDialog.show(context, onTap: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.addProductScreen)?.then((value){
                                    contt.onInit();
                                  });
                                });
                              }
                              else if (value.status == false) {
                                showToastError('${value.message}');
                              }
                            });
                          } else {
                            showToastError('Please accept Terms & Conditions');
                          }



                        };
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          // border: Border.all(
                          //   color: AppColors.orangeColor,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: addText700(
                            "Save & Continue", textAlign: TextAlign.start,
                            color: AppColors.blackColor),
                      ),
                    ),

                    SizedBox(height: 30,),

                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
