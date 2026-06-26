import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/notification/notification.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationListController extends IOController {
  final titleText = 'Мэдэгдэл';
  final refreshController = RefreshController();
  final notificationItems = <NotificationListModel>[].obs;
  final pagination = PaginationModel();

  @override
  void onInit() {
    super.onInit();
    getData(true);
  }

  void onTapItem(NotificationListModel item) {
    AppRoute.toNotificationDialog(item: item).then((_) {
      notificationItems.refresh();
    });
  }

  Future onRefresh() async {
    pagination.reset();
    getData(false);
  }

  Future onLoad() async {
    getData(false);
  }

  Future getData(bool isInitial) async {
    if (!pagination.shouldFetch) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      return;
    }

    if (isInitial) isInitialLoading.value = true;

    final response = await CustomerApi().getNotificationList(
      offset: pagination.offset,
      limit: pagination.limit,
    );

    if (isInitial) isInitialLoading.value = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();

    if (response.isSuccess) {
      final items = response.data['results'].listValue
          .map((e) => NotificationListModel.fromJson(e))
          .toList();
      if (pagination.isInitial) {
        notificationItems.value = items;
      } else {
        notificationItems.addAll(items);
      }
      pagination.setValue(
        itemCount: notificationItems.length,
        count: response.data['count'].integerValue,
      );
    } else {
      if (isInitial) {
        Get.back();
      }
      showError(text: response.msg);
    }
  }
}
