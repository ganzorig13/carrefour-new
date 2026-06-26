import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GiftCardsController extends IOController {
  final refreshController = RefreshController();
  final controller = Get.find<CardsTabController>();

  final giftCartAdd = IOButtonModel(
    label: 'Бэлгийн карт нэмэх',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    prefixIcon: 'gift_button.svg',
  );

  void onTapGiftCardAdd() {
    Get.back();
    MenuRoute.toGiftCardQrScan();
  }

  void onTapDetailScreen(GiftCardsModel item) {
    MenuRoute.toCardDetailScreen(item: item);
  }
}
