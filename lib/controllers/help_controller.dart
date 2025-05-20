import 'package:flipzy/Api/api_models/faq_model_response.dart';
import 'package:flipzy/Api/repos/faq_quest_repo.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {

  FrequentlyAskQuestionsModel model = FrequentlyAskQuestionsModel();
  bool isDataLoading = false;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
  fetchData() async{
    isDataLoading = true;
    update();
    faqApi().then((faq){
      model = faq;
      isDataLoading = false;
      update();
    });
  }






  List<HelpItems> helpItemsList = [
    HelpItems(id: 1, isSelect: false, question: "Why should I complete my business profile ?", answer: "Completing your profile increases your business’s credibility, improves visibility, and helps customers find and trust you."),
    HelpItems(id: 2, isSelect: false,  question: "What if I don't have website ?", answer: "Completing your profile increases your business’s credibility, improves visibility, and helps customers find and trust you."),
    HelpItems(id: 3, isSelect: false,  question: "Can I edit my business details later ?", answer: "Completing your profile increases your business’s credibility, improves visibility, and helps customers find and trust you."),
    HelpItems(id: 4, isSelect: false,  question: "What happens if I don't complete my profile ?", answer: "Completing your profile increases your business’s credibility, improves visibility, and helps customers find and trust you."),
    // HelpItems(id: 5, isSelect: false,  question: "What happens if I don't complete my profile ?", answer: "Completing your profile increases your business’s credibility, improves visibility, and helps customers find and trust you."),
  ];

}

class HelpItems {
  int id;
  String question;
  String answer;
  bool isSelect;
  HelpItems({this.id = 0, this.question = "", this.answer = "", this.isSelect = false});
}