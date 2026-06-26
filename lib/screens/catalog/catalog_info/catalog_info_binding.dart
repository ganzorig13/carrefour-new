import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class CatalogInfoBinding extends Bindings {
  final int catalogId;
  CatalogInfoBinding({required this.catalogId});

  @override
  void dependencies() {
    Get.lazyPut(() => CatalogInfoController(catalogId: catalogId));
  }
}
