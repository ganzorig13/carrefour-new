import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PurchaseListController extends IOController {
  final titleText = 'Худалдан авалтын түүх';
  final emptyText = 'Худалдан авалтын түүх байхгүй';
  final historyItems = <PurchaseListModel>[].obs;
  final pagination = PaginationModel();
  final refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    getHistory(true);
  }

  Future onLoad() async {
    getHistory(false);
  }

  Future onRefresh() async {
    pagination.reset();
    getHistory(false);
  }

  Future getHistory(bool initial) async {
    if (!pagination.shouldFetch) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      return;
    }

    if (initial) isInitialLoading.value = true;
    final response = await CustomerApi().getPurchaseHistory(
      limit: pagination.limit,
      offset: pagination.offset,
    );
    if (initial) isInitialLoading.value = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();

    if (response.isSuccess) {
      final items = response.data['results'].listValue
          .map((e) => PurchaseListModel.fromJson(e))
          .toList();
      if (pagination.isInitial) {
        historyItems.value = items;
      } else {
        historyItems.addAll(items);
      }
      pagination.setValue(
        itemCount: historyItems.length,
        count: response.data['count'].integerValue,
      );
    } else {
      if (initial) {
        Get.back();
      }
      showError(text: response.msg);
    }
  }

  void onTapItem(PurchaseListModel item) {
    MenuRoute.toPurchaseDetail(item: item);
  }
}
