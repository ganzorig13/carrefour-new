import 'package:carrefour/library/library.dart';
import 'package:carrefour/main_controller.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PromoListController extends IOController {
  final main = Get.find<MainController>();
  final emptyText = 'Урамшуулал байхгүй';
  final PromoPageType type;
  final items = <PromoListModel>[].obs;
  final refreshController = RefreshController(initialRefresh: false);

  PromoListController({required this.type});

  @override
  void onInit() {
    super.onInit();
    Get.find<PromoPageController>().refreshNotifier.addListener(onChanged);
    getData(true);
  }

  void onChanged() {
    getData(true);
  }

  Future onRefresh() async {
    // pagination.reset();
    getData(false);
  }

  Future getData(bool initial) async {
    if (initial) isInitialLoading.value = true;
    final response = await CustomerApi().getPromoList(
      type: type.value,
    );

    if (initial) isInitialLoading.value = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();

    if (response.isSuccess) {
      items.value = response.data.listValue
          .map((e) => PromoListModel.fromJson(e))
          .toList();
    }
  }
}
