import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class PromoSurveyController extends IOController {
  final titleText = 'Судалгаа';
  final int id;
  final PromoListModel promo;
  final question = PromoSurveyModel.fromJson(JSON.nil).obs;

  final submitButton = IOButtonModel(
    label: 'Дуусгах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  PromoSurveyController({
    required this.id,
    required this.promo,
  });

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future getInfo() async {
    isInitialLoading.value = true;
    final response = await CustomerApi().getPromoSurveyDetail(id: id);
    isInitialLoading.value = false;

    if (response.isSuccess) {
      question.value = PromoSurveyModel.fromJson(response.data);
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future onTapSubmit() async {
    isLoading.value = true;
    submitButton.update((val) {
      val?.isLoading = true;
    });

    final data = {
      'survey_id': id,
      'responses': question.value.questions.map((e) => e.toMap()).toList()
    };

    final response = await CustomerApi().submitPromoSurvey(data: data);

    isLoading.value = false;
    submitButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.back();
      Get.find<PromoPageController>().refreshNotifier.notify();
    } else {
      showError(text: response.msg);
    }
  }

  void checkButton() {
    submitButton.update((val) {
      val?.isEnabled = question.value.isValid;
    });
  }

  void onTapAnswer(int questionIndex, PromoAnswerModel answer) {
    final item = question.value.questions[questionIndex];
    switch (item.questionType) {
      case PromoQuestionType.single:
        for (final item in item.answers) {
          item.selected = item.id == answer.id;
        }
        break;
      case PromoQuestionType.multiple:
        answer.selected = !answer.selected;
        break;
      default:
        break;
    }
    checkButton();
    question.refresh();
  }
}
