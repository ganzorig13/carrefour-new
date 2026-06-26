import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards_detail/gift_cards_detail_controller.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_cards_model.dart';
import 'package:get/get.dart';

class GiftCardsDetailBinding extends Bindings {
  final GiftCardsModel item;

  GiftCardsDetailBinding({
    required this.item,
  });
  @override
  void dependencies() {
    Get.lazyPut(() => GiftCardsDetailController(item: item));
  }
}
