import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PromoSurveyBinding extends Bindings {
  final int id;
  final PromoListModel promo;
  PromoSurveyBinding({required this.id, required this.promo});
  @override
  void dependencies() {
    Get.lazyPut(
      () => PromoSurveyController(
        id: id,
        promo: promo,
      ),
    );
  }
}
