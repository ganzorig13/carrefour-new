import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class PromoBannerBinding extends Bindings {
  final List<PromoBannerModel> items;
  final int index;

  PromoBannerBinding({
    required this.items,
    required this.index,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => PromoBannerController(items: items, index: index),
    );
  }
}
