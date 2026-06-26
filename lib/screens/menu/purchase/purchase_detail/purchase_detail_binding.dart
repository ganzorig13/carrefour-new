import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PurchaseDetailBinding extends Bindings {
  final PurchaseListModel item;
  PurchaseDetailBinding({required this.item});

  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseDetailController(item: item));
  }
}
