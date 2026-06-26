import 'package:get/get.dart';
import 'package:carrefour/library/library.dart';

class IOController extends GetxController {
  final isInitialLoading = false.obs;
  final isLoading = false.obs;
  final user = HelperManager.user.obs;
  final count = HelperManager.notifCount.obs;

  Future<bool?> showSuccess({
    required String text,
    String? titleText,
    String? buttonText,
    bool dismissable = true,
  }) {
    return IOAlert(
      type: IOAlertType.success,
      titleText: titleText,
      bodyText: text,
      acceptText: buttonText ?? 'Хаах',
      dismissable: dismissable,
    ).show();
  }

  Future<bool?> showError({
    required String text,
    String? titleText,
    String? buttonText,
  }) {
    return IOAlert(
      type: IOAlertType.warning,
      titleText: titleText,
      bodyText: text,
      acceptText: buttonText ?? 'Хаах',
    ).show();
  }

  Future<bool?> showWarning({
    required String text,
    String? titleText,
    String? acceptText,
    String? cancelText,
  }) {
    return IOAlert(
      type: IOAlertType.warning,
      titleText: titleText,
      bodyText: text,
      acceptText: acceptText,
      cancelText: cancelText,
    ).show();
  }

  @override
  void onInit() {
    super.onInit();
    UserStoreManager.shared.store.listenKey(kNotificationCount, (_) {
      count.value = HelperManager.notifCount;
    });
  }

  void onTapNotfication() {
    AppRoute.toNotificationList()?.then((_) {
      ClientManager.getNotificationCount();
    });
  }
}
