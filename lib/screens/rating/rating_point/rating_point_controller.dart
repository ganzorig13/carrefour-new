import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class RatingPointController extends IOController {
  final int id;
  final rateItems = [
    RatingPointModel(
      point: 1,
      icon: 'emoji.1.svg',
      name: 'Маш муу',
    ),
    RatingPointModel(
      point: 2,
      icon: 'emoji.2.svg',
      name: 'Яахав дээ',
    ),
    RatingPointModel(
      point: 3,
      icon: 'emoji.3.svg',
      name: 'Дундаж',
    ),
    RatingPointModel(
      point: 4,
      icon: 'emoji.4.svg',
      name: 'Сайн',
    ),
    RatingPointModel(
      point: 5,
      icon: 'emoji.5.svg',
      name: 'Маш сайн',
    ),
  ];
  final rate = RatingModel.fromJson(JSON.nil).obs;

  RatingPointController({required this.id});

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  void onTapPoint(RatingPointModel item) {
    if (item.point < 3) {
      Get.back();
      AppRoute.toRatingQuestion(
        id: id,
        point: item.point,
        rateInfo: rate.value,
      );
    } else {
      sendRating(item);
    }
  }

  Future getInfo() async {
    isInitialLoading.value = true;
    final response = await CustomerApi().getRateInfo();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      rate.value = RatingModel.fromJson(response.data);
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future sendRating(RatingPointModel item) async {
    isLoading.value = true;

    final response = await CustomerApi().sendRateInfo(
      id: id,
      answer: item.name,
      point: item.point,
    );

    isLoading.value = false;

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
