import 'package:flipzy/Api/repos/default_address_repo.dart';
import 'package:flipzy/Api/repos/delete_address_repo.dart';
import 'package:flipzy/controllers/get_all_address_ctrl.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AllAddressScreen extends StatefulWidget {
  const AllAddressScreen({super.key});

  @override
  State<AllAddressScreen> createState() => _AllAddressScreenState();
}

class _AllAddressScreenState extends State<AllAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          backgroundColor: AppColors.whiteColor,
          leadingWidth: MediaQuery
              .of(context)
              .size
              .width * 0.3,
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
          titleTxt: "Shipping Address",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
          actionItems: [
            IconButton(
                tooltip: 'Add address',
                onPressed: () {
                  Get.toNamed(AppRoutes.addAddressScreen,
                      arguments: {'is_edit': false});
                }, icon: Icon(Icons.add, color: Colors.black,)),
            addWidth(10)
          ]
      ),
      body: GetBuilder<GetAllAddressCtrl>(builder: (logic) {
        return logic.isDataLoading
            // ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor,))
            ? Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: 5,
            itemBuilder: (_, __) => Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 100,
            ),
          ),
        )
            : logic.addressList.isNotEmpty
            ? SingleChildScrollView(
          child: Column(
            children: [
              addHeight(20),

              ...List.generate(logic.addressList.length, (index){
                final address = logic.addressList[index];
                return build_address_box(
                    onTap: (){
                    if(address.isDefault==false){
                      showLoader(true);
                      defaultAddressApi(addressId: address.id).then((value){
                        showLoader(false);
                        if(value.status==true){
                          showToast('${value.message}');
                          logic.addressList.forEach((action){
                            action.isDefault = false;
                          });


                          logic.addressList[index].isDefault = true;
                          logic.update();
                        }
                      });
                    }
                  },
                    addressType: address.isDefault==true?'Default':'Make Default',
                    fullAddress: '${logic.addressList[index].address}',
                    landmark: 'Landmark: ${logic.addressList[index].landmark}',
                    isSelected: address.isDefault!,
                    onTapEdit: (){
                    Get.toNamed(AppRoutes.addAddressScreen,
                        arguments: {'is_edit':true,'address_detail':address});
                  },
                    onTapDelete: (){
                    showLoader(true);
                    deleteAddressApi(addressId: address.id).then((value){
                      showLoader(false);
                      if(value.status==true){
                        showToast('${value.message}');
                        logic.addressList.removeAt(index);
                        logic.update();
                      }
                    });
                  }

                );
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(address.isDefault==false){
                          showLoader(true);
                          defaultAddressApi(addressId: address.id).then((value){
                            showLoader(false);
                            if(value.status==true){
                              showToast('${value.message}');
                              logic.addressList.forEach((action){
                                action.isDefault = false;
                              });


                              logic.addressList[index].isDefault = true;
                              logic.update();
                            }
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: address.isDefault==true? AppColors.primaryColor:AppColors.containerBorderColor1),
                          borderRadius: BorderRadius.circular(16)
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addText500('${logic.addressList[index].address}',fontSize: 13,fontFamily: 'Manrope'),
                              addHeight(4),
                              richText2(
                                  textAlign: TextAlign.left,
                                  text1: 'Landmark: ',fontSize: 13,
                                  text2: '${logic.addressList[index].landmark}',fontSize2: 12)
                            ],
                          ).marginAll(12)).marginOnly(bottom: 16),
                    ),
                    if(address.isDefault==false)
                    Positioned(
                      right: 12,
                      top: -12,


                      child: InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.addAddressScreen,
                              arguments: {'is_edit':true,'address_detail':address});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.primaryColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('Edit', fontSize: 12,
                                  fontFamily: 'Manrope',
                                  color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 8, vertical: 2),
                        ),
                      ),),

                    if(address.isDefault==false)
                    Positioned(
                      right: 60,
                      top: -12,


                      child: InkWell(
                        onTap: (){
                          showLoader(true);
                          deleteAddressApi(addressId: address.id).then((value){
                            showLoader(false);
                            if(value.status==true){
                              showToast('${value.message}');
                              logic.addressList.removeAt(index);
                              logic.update();
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.primaryColor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(AppAssets.starImage,height: 13,width: 13).marginOnly(right: 4),
                              addText500('Delete', fontSize: 12,
                                  fontFamily: 'Manrope',
                                  color: AppColors.blackColor),
                            ],
                          ).marginSymmetric(horizontal: 8, vertical: 2),
                        ),
                      ),),
                  ],
                );
              })
            ],
          ),
        )
            : Center(child: addText500('No data found'));
      }),
    );
  }
  build_address_box({String? addressType, String? fullAddress,String? landmark,
    bool isSelected = false, void Function()? onTap, void Function()? onTapEdit, void Function()? onTapDelete}) {
    return GestureDetector(
    onTap: onTap,
    child: Container(
      width: MediaQuery
          .sizeOf(context)
          .width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.lightGreyColor : AppColors.blueLightColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColors.primaryColor : AppColors.containerBorderColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              addText500('$addressType', fontSize: 15, color: isSelected ? AppColors.greenColor : AppColors.redColor,fontFamily: 'Manrope'),
              Spacer(),
              buildPopUp(onTapEdit: onTapEdit, onTapDelete: isSelected==false ?onTapDelete:null)
            ],
          ),
          addHeight(4),
          addText500('${fullAddress}', fontSize: 13, color: AppColors.blackColor,fontFamily: 'Manrope'),

          addHeight(4),
          addText400('${landmark!.capitalize}', fontSize: 13, color: AppColors.textColor1,fontFamily: 'Manrope'),


        ],
      ),

    ).marginOnly(left: 20, right: 20, bottom: 12),
  );}

  buildPopUp({void Function()? onTapEdit, void Function()? onTapDelete}) {
    return Container(
      height: 20,
      width: 20,
      child: PopupMenuButton(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
          icon: Icon(Icons.more_vert),
          offset: Offset(0, 22),
          tooltip: 'Delete or Edit Address',
          shadowColor: AppColors.containerBorderColor,

          //add offset to fix it
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: onTapEdit,
                  height: 30,
                  padding: EdgeInsets.only(left: 12),
                  value: 'Edit',
                  child: addText400('Edit', fontSize: 14, color: AppColors.blackColor,fontFamily: 'Manrope')),
              if(onTapDelete!=null)
              PopupMenuItem(
                  onTap: onTapDelete,
                  height: 30,
                  padding: EdgeInsets.only(left: 12),
                  value: 'Delete',
                  child: addText400('Delete', fontSize: 14, color: AppColors.blackColor,fontFamily: 'Manrope')),

            ];
          }),
    );
  }
}
