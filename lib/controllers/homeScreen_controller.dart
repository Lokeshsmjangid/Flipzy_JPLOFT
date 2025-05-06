import 'package:flipzy/Api/api_models/home_model_response.dart';
import 'package:flipzy/Api/repos/home_page_repo.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  HomeModelResponse homeModel = HomeModelResponse();
  TextEditingController searchCtrl = TextEditingController();
  bool isDataLoading = false;
  final deBounce = Debouncer(milliseconds: 1000);

  //AppAssets.categoryShoeImg, AppAssets.categoryShoeImg, AppAssets.categoryShoeImg,

  bool openDrawer = false;

  late int currentIndex ;
  List<CategoryItems> categoryItems= [
    CategoryItems(isSelect: true, images: AppAssets.categoryImg1),
    CategoryItems(isSelect: false, images: AppAssets.categoryImg2),
    CategoryItems(isSelect: false, images: AppAssets.categoryImage3),
    CategoryItems(isSelect: false, images: AppAssets.categoryImage4),
    CategoryItems(isSelect: false, images: AppAssets.categoryImage5),
  ];

  List<FeaturedItems> featuredItems = [
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 1),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenIphone2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
  ];

  List<FeaturedItems> featuredBikes = [
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike1 , price: "100,000", title: "Suzuki Red Dragon", rating: "4.4", isFeatured: 1),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike2 , price: "100,000", title: "Suzuki Kawasaki", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike1 , price: "100,000", title: "Suzuki Red Dragon", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike2 , price: "100,000", title: "Suzuki Kawasaki", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike1 , price: "100,000", title: "Suzuki Red Dragon", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.homeScreenBike2 , price: "100,000", title: "Suzuki Kawasaki", rating: "4.4", isFeatured: 0),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      // showLoader(true);
      fetchHomeData();
    });
  }

  fetchHomeData() async {
    isDataLoading = true;
    update();
    await getHomeApi().then((value){

      homeModel = value;
      isDataLoading = false;
      // showLoader(false);
      update();
    });
  }


}

class CategoryItems {
  bool isSelect ;
  String images = "";

  CategoryItems({this.isSelect = false, this.images = ""});
}

class FeaturedItems {
  bool isFavourite ;
  String images = "";
  String price = "";
  String title = "";
  String rating = "";
  int isFeatured;

  FeaturedItems({this.isFavourite = false, this.images = "",
    this.price = "", this.title = "", this.rating = "", this.isFeatured = 0});
}