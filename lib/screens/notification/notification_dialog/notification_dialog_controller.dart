import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/notification/notification.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class NotificationDialogController extends IOController {
  final NotificationListModel item;

  bool get hasAction => item.actionType.isNotEmpty;

  NotificationDialogController({required this.item});

  final closeButton = IOButtonModel(
    label: 'Хаах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
  );

  final nextButton = IOButtonModel(
    label: 'Дэлгэрэнгүй',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  );

  @override
  void onInit() {
    super.onInit();
    getDetail();
  }

  void onTapClose() {
    Get.back();
  }

  void onTapNext() {
    Get.back();
    DynamicRoute.handleAction(JSON(item.toMap()));
  }

  Future getDetail() async {
    final response = await CustomerApi().getNotificationDetail(id: item.id);
    if (response.isSuccess) {
      item.isViewed = true;
      refresh();
    }
  }
}
