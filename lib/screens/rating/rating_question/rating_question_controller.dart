import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class RatingQuestionController extends IOController {
  final int id;
  final int point;
  final RatingModel rateInfo;

  final selectedIndex = (-1).obs;

  final otherField = IOTextfieldModel(
    label: '',
    placeholder: 'Шалтгаанаа бичнэ үү',
    validators: [ValidatorType.notEmpty],
    hasTitle: false,
    hasBorder: true,
  );

  final sendButton = IOButtonModel(
    label: 'Илгээх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  ).obs;

  bool get isOther => selectedIndex.value == rateInfo.answerchoices.length;

  RatingQuestionController({
    required this.id,
    required this.point,
    required this.rateInfo,
  });

  @override
  void onInit() {
    super.onInit();
    otherField.status.addListener(checkValidation);
    checkValidation();
  }

  void checkValidation() {
    if (isOther) {
      sendButton.update((val) {
        val?.isEnabled = otherField.isValid;
      });
    } else {
      sendButton.update((val) {
        val?.isEnabled = selectedIndex.value != -1;
      });
    }
  }

  void onSelected(int index) {
    selectedIndex.value = index;
    checkValidation();
  }

  void onTapSend() {
    Get.focusScope?.unfocus();
    late String answer;
    if (isOther) {
      answer = otherField.value;
    } else {
      answer = rateInfo.answerchoices[selectedIndex.value].answer;
    }
    sendRating(answer);
  }

  Future sendRating(String answer) async {
    isLoading.value = true;
    sendButton.update((val) {
      val?.isLoading = true;
    });

    final response = await CustomerApi().sendRateInfo(
      id: id,
      answer: answer,
      point: point,
    );

    isLoading.value = false;
    sendButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      if (Get.isRegistered<NotificationListController>()) {
        Get.find<NotificationListController>().onRefresh();
      }
      Get.back();
      showSuccess(
        titleText: 'Баярлалаа',
        text: 'Таны үнэлгээ амжилттай илгээгдлээ',
      );
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }
}
