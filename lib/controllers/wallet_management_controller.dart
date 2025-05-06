import 'package:flipzy/Api/api_models/transaction_response.dart';
import 'package:flipzy/Api/api_models/user_available_balance_model.dart';
import 'package:flipzy/Api/repos/get_userbalance_repo.dart';
import 'package:flipzy/Api/repos/transactions_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WalletManagementController extends GetxController {
  // TransactionResponse response = TransactionResponse();
  UserBalanceResponse response = UserBalanceResponse();
  TextEditingController withdrawalCtrl = TextEditingController();




bool isDataLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTransactions();
  }

  fetchTransactions() async{
    isDataLoading = true;
    update();
    await getUserBalanceApi().then((value){
    response = value;
    isDataLoading = false;
    update();
    });
  }




}