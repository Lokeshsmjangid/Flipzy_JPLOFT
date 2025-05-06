import 'package:get/get.dart';

import '../resources/app_assets.dart';

class ProductManagementController extends GetxController {

  List<FeaturedItems> featuredItems = [
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 1),
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg1 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
    FeaturedItems(isFavourite: false, images: AppAssets.iphoneImg2 , price: "60,0000", title: "Apple Iphone 15", rating: "4.4", isFeatured: 0),
  ];

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