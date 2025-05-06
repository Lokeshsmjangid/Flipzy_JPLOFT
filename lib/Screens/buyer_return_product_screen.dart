import 'dart:io';

import 'package:flipzy/Api/repos/apply_product_return_repo.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart' show customAppBar;
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/custom_text_field.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BuyerReturnReasonScreen extends StatefulWidget {
  String? orderId;
  BuyerReturnReasonScreen({this.orderId});
  @override
  _BuyerReturnReasonScreenState createState() => _BuyerReturnReasonScreenState();
}

class _BuyerReturnReasonScreenState extends State<BuyerReturnReasonScreen> {

  ProductReturnReason? selectedReason;
  TextEditingController msgController = TextEditingController();
  final List<ProductReturnReason> reasonsList = [
    ProductReturnReason(reasonTitle: 'Change of mind',sendingTag: "ChangedMyMind",canFullyRefund: false),
    ProductReturnReason(reasonTitle: 'Defective or Damaged',sendingTag:"DamagedItem",canFullyRefund: true),
    ProductReturnReason(reasonTitle: 'Item not as described', sendingTag: "ItemNotAsDescribed",canFullyRefund: true),
  ];

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];

  Future<void> pickImageFromCamera() async {
    if (selectedImages.length >= 4) {
      Get.snackbar('Limit reached', 'You can only add up to 4 images.');
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImages.add(image);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 16,),
              addText400("Back", color: AppColors.blackColor),
            ],
          ).marginOnly(left: 12),
        ),
        centerTitle: true,
        titleTxt: "Problem With Product",
        titleColor: AppColors.blackColor,
        titleFontSize: 18,
        actionItems: [
        ],
        bottomLine: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...reasonsList.map((reason) {
              return RadioListTile<ProductReturnReason>(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                title: addText500('${reason.reasonTitle}'),
                value: reason,
                groupValue: selectedReason,
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                  if(selectedReason!.sendingTag=='ChangedMyMind'){
                    selectedImages=[];
                    setState(() {});
                  }
                },
              );
            }).toList(),
            addHeight(20),

            Align(
                alignment: Alignment.centerLeft,
                child: addText500('Describe your reason')).marginOnly(bottom: 6,left: 4),
            CustomTextField(
                controller: msgController,
                hintText: 'Tell us more...',maxLines: 4),


            if(selectedReason!=null && selectedReason!.sendingTag!="ChangedMyMind")
            Align(
              alignment: Alignment.centerLeft,
              child: addText500('Upload Images (max 4)'),
            ).marginOnly(bottom: 6, left: 4,top: 16),

            if(selectedReason!=null && selectedReason!.sendingTag!="ChangedMyMind")
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...selectedImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    XFile img = entry.value;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(img.path),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -6,
                          right: -6,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImages.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.7),
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  if (selectedImages.length < 4)
                    GestureDetector(
                      onTap: pickImageFromCamera,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.shade100,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.grey),
                      ),
                    ),
                ],
              ),

            AppButton(buttonText: 'Apply',onButtonTap: (){
              if(selectedReason==null){
                showToastError('Please select an reason');
              } else if(msgController.text.isEmpty){
                showToastError('Please tell us more');
              } else if(selectedReason!.sendingTag=='DamagedItem' || selectedReason!.sendingTag=='ItemNotAsDescribed' && selectedImages.isEmpty){
                showToastError('Please add some live images');

              } else{
               showLoader(true);
               applyProductReturnApi(
                   orderId: widget.orderId,
                   reason: msgController.text,
                   reasonType: '${selectedReason!.sendingTag}',
                 productImages: selectedImages.map((xfile) => File(xfile.path)).toList()

               ).then((value){
                 showLoader(false);
                 if(value.status==true){
                   showToast('${value.message}');
                   Future.microtask((){
                     Get.back();
                     Get.back();
                   });

                 }else if(value.status==false){
                   showToastError('${value.message}');
                 }
               });
              }

            },).marginOnly(top: 20)



          ]
        ).marginSymmetric(horizontal: 16),
      ),
    );
  }
}

class ProductReturnReason {
  String? reasonTitle;
  String? sendingTag;
  bool? canFullyRefund;
  ProductReturnReason({this.reasonTitle,this.sendingTag,this.canFullyRefund});
}