import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PromoDetailBinding extends Bindings {
  final int id;

  PromoDetailBinding({required this.id});
  @override
  void dependencies() {
    Get.lazyPut(() => PromoDetailController(id: id));
  }
}
