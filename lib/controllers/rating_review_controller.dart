import 'package:flipzy/Api/api_models/rating_reviews_model.dart';
import 'package:flipzy/Api/repos/get_rating_review_repo.dart';
import 'package:get/get.dart';

class RatingReviewsController extends GetxController{
  RatingReviewsResponse reviewsResponse = RatingReviewsResponse();
  bool isDataLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      fetchRatingReviewsData();
    });
  }

  fetchRatingReviewsData() async {
    isDataLoading = true;
    update();
    await getRatingReviewApi().then((value){

      reviewsResponse = value;
      isDataLoading = false;
      update();
    });
  }



}