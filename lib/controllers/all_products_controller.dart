import 'dart:convert';
import 'dart:developer';
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/place_auto_complate_response.dart';
import 'package:http/http.dart' as http;
import 'package:flipzy/Api/api_models/my_products_model_response.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/autocomplate_prediction.dart';
import 'package:flipzy/Api/repos/all_products_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../resources/app_color.dart';
import '../resources/custom_loader.dart';
import 'enable_location_controller.dart';

class AllProductsController extends GetxController{
  // for filter
  TextEditingController filterLocation = TextEditingController();
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

  RxList<ShortBy> shortList = <ShortBy>[
    ShortBy(shortVal: "Featured".obs, isSelect: false.obs,shortValSend: "featured".obs),
    ShortBy(shortVal: "Newest".obs, isSelect: false.obs,shortValSend: "newest".obs),
    ShortBy(shortVal: "Lowest Price".obs, isSelect: false.obs,shortValSend: "lowestPrice".obs),
    ShortBy(shortVal: "Highest Price".obs, isSelect: false.obs,shortValSend: "highestPrice".obs),
  ].obs ;

  Rx<RangeValues> currentRangeValues = const RangeValues(1, 5000).obs;


  List<AutocompletePrediction> placePredication = [];
  void getSuggestion(String query) async{
    Uri uri = Uri.https('maps.googleapis.com','maps/api/place/autocomplete/json',{
      'key': ApiUrls.googleApiKey,
      'input': query,
      'components': 'country:ng', // only for nigeria
    });

    String? response = await fetchUrl(uri);
    if(response !=null){
      log('AutoCompleteResponse $response');
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if(result.predictions!=null){
        placePredication = result.predictions!;
        update();
      }
    }

  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers); // Await the HTTP request
      if (response.statusCode == 200) {
        // Do something with the response here if needed
        return response.body; // Return response body or whatever you need
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  Future<PlaceDetails> getAddressFromPlaceId(String placeId) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,geometry&key=${ApiUrls.googleApiKey}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final addressComponents = data['result']['address_components'];
      final geometry = data['result']['geometry'];

      String address = '';
      String city = '';
      String state = '';
      String country = '';
      String postalCode = '';
      double latitude = 0.0;
      double longitude = 0.0;

      for (var component in addressComponents) {

        List<dynamic> types = component['types'];
        if (types.contains('street_number') || types.contains('route')) {
          address += component['long_name'] + ', ';
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          state = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      latitude = geometry['location']['lat'];
      longitude = geometry['location']['lng'];
      showLoader(false);
      return PlaceDetails(
        responseCode: 200,
        address: address.isEmpty ? '' : address.substring(0, address.length - 2),
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
        latitude: latitude,
        longitude: longitude,
      );
    } else {
      showLoader(false);

      throw Exception('Failed to load place details');
    }
  }

  // for filter





  MyProductsModelResponse modelResponse = MyProductsModelResponse();
  TextEditingController searchController = TextEditingController();
  bool isDataLoading = false;
  bool isPageLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  String? searchTerm;
  int page =1;
  int? maxPage;
  ScrollController? paginationScrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
      searchTerm = Get.arguments['searchTerm'];
      searchController.text = '$searchTerm';
      fetchMyProductsListData(searchValue: searchTerm, pageNumm: 1,ISFILTER: false);
      paginationScrollController = new ScrollController()..addListener(_scrollListener);


    }
  }


  @override
  void dispose() {
    paginationScrollController?.removeListener(_scrollListener);
    super.dispose();
  }


  _scrollListener() {
    bool isLoadingAll = page > maxPage!?true:false;
    flipzyPrint(message: '${paginationScrollController?.position.atEdge}'); // allowImplicitScrolling,hasViewportDimension, keepScrollOffset
    bool isTop = paginationScrollController?.position.pixels == 0;
    flipzyPrint(message: 'isTop:::${isTop}');
    flipzyPrint(message: 'Page:::${page}');
    flipzyPrint(message: 'maxPage:::${maxPage}');
    flipzyPrint(message: 'isLoadingAll:::${isLoadingAll}');
    if(paginationScrollController!=null && paginationScrollController!.position.atEdge && isTop==false && isLoadingAll==false){
      Future.microtask((){
        deBounce.run(() {
          isPageLoading = false;
          page++;
          update();
        });

      });
    }
    if (paginationScrollController!.position.atEdge && isTop==false && isPageLoading == false) {
      // if (paginationScrollController!.position.extentAfter <= 0 && isPageLoading == false) {
      if(isLoadingAll==false){
        Future.microtask((){
          fetchMyProductsListData(pageNumm: page,ISFILTER: false);
        });
      } else{
        showToastError('That\'s all for now.');
      }

    }
  }

  fetchMyProductsListData({searchValue,pageNumm,PRICE,ISFILTER,SORT,PD}) async {
    isPageLoading = true;
    if(page==1)
    isDataLoading = true;
    update();
    await getAllProductsListApi(searchTerm: searchValue,
        page: pageNumm,
      price: PRICE,isFilter: ISFILTER,location: filterLocation.text,sortBy: SORT,productCondition: PD

    ).then((value){


      if (page == 1) {
        modelResponse = value;
        isDataLoading = false;
        maxPage = value.totalPages;
      }else {
        modelResponse.myProducts!.addAll(value.myProducts??[]);
      }
      update();
    });
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

class ShortBy {
  RxString? shortVal = "".obs ;
  RxString? shortValSend = "".obs ;
  RxBool? isSelect = false.obs;

  ShortBy({this.shortVal ,this.shortValSend , this.isSelect});

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
                  child: addText500('₦1',fontFamily: '')),
              addText500('₦5000+',fontFamily: ''),
            ],
          ),
          RangeSlider(
            values: rangeVal.value,
            min: 1,
            max: 5000,
            divisions: 1000,

            labels: RangeLabels(
              '${rangeVal.value.start.round()}',
              '${rangeVal.value.end.round()}',
            ),
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.greyColor,
            onChanged: (RangeValues values) {
              rangeVal.value = values;
            },
          ),
          addHeight(10),

        ],
      ),
    );
  });
}