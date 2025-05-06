import 'package:flipzy/Api/api_models/notification_model.dart';
import 'package:flipzy/Api/repos/get_notifications_repo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationModelResponse modelResponse = NotificationModelResponse();
  bool isDataLoading =false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.microtask((){
      fetchNotificationsListData();
    });
  }

  fetchNotificationsListData() async {
    isDataLoading = true;
    update();
    await getNotificationListApi().then((value){

      modelResponse = value;
      isDataLoading = false;
      update();
    });
  }


}