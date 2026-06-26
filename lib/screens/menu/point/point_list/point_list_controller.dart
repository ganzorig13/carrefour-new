import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum PointListType { spend, collect }

class PointListController extends IOController {
  final PointListType type;
  final emptyText = 'Онооны түүх байхгүй';
  final pagination = PaginationModel();
  final refreshController = RefreshController(initialRefresh: false);
  final pointItems = <PointListModel>[].obs;

  PointListController({
    required this.type,
  });

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
    final response = await CustomerApi().getPointHistory(
      type: type.name,
      limit: pagination.limit,
      offset: pagination.offset,
    );
    if (initial) isInitialLoading.value = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();

    if (response.isSuccess) {
      final items = response.data['results'].listValue
          .map((e) => PointListModel.fromJson(e, type))
          .toList();
      if (pagination.isInitial) {
        pointItems.value = items;
      } else {
        pointItems.addAll(items);
      }
      pagination.setValue(
        itemCount: pointItems.length,
        count: response.data['count'].integerValue,
      );
    } else {
      if (initial) {
        Get.back();
      }
      showError(text: response.msg);
    }
  }
}
