import 'package:app_settings/app_settings.dart';
import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuTabController extends IOSuperController {
  final user = HelperManager.user.obs;
  final isNotificationEnabled = false.obs;
  final isBiometricEnabled = HelperManager.isEnabledBiometricPin.obs;
  List<MenuTabModel> get items {
    final employeeCard = Get.find<CardsTabController>().employeeCard;
    final showEmployeeCard = employeeCard != null;
    return [
      MenuTabModel(
        title: '',
        items: [
          if (showEmployeeCard)
            MenuTabItemModel(type: MenuTabItemType.employeeCard),
          MenuTabItemModel(type: MenuTabItemType.giftCard),
          MenuTabItemModel(type: MenuTabItemType.pointHistory),
          MenuTabItemModel(type: MenuTabItemType.buyHistory),
          MenuTabItemModel(type: MenuTabItemType.myFinance),
        ],
      ),
      MenuTabModel(
        title: 'Тохиргоо',
        items: [
          MenuTabItemModel(type: MenuTabItemType.pinChange),
          MenuTabItemModel(
            type: MenuTabItemType.biometric,
            value: isBiometricEnabled.value,
          ),
          MenuTabItemModel(
            type: MenuTabItemType.notification,
            value: isNotificationEnabled.value,
          ),
          MenuTabItemModel(
            type: MenuTabItemType.ebarimt,
            isSvg: false,
          ),
        ],
      ),
      MenuTabModel(
        title: 'Бусад',
        items: [
          MenuTabItemModel(type: MenuTabItemType.contact),
          MenuTabItemModel(type: MenuTabItemType.faq),
          MenuTabItemModel(type: MenuTabItemType.branch),
          MenuTabItemModel(type: MenuTabItemType.terms),
          MenuTabItemModel(type: MenuTabItemType.policy),
        ],
      ),
    ];
  }

  final logoutButton = IOButtonModel(
    label: 'Системээс гарах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    enabledBackgroundColor: IOColors.secondary500,
  );

  @override
  void onInit() {
    super.onInit();
    isEnabledNotification();
    UserStoreManager.shared.store.listenKey(kUser, (_) {
      user.value = HelperManager.user;
    });
    UserStoreManager.shared.store.listenKey(kBiometricEnabledPin, (_) {
      isBiometricEnabled.value = HelperManager.isEnabledBiometricPin;
      refresh();
    });
  }

  @override
  void onResumed() {
    super.onResumed();
    isEnabledNotification();
  }

  void onTapProfile() {
    MenuRoute.toProfile();
  }

  void openNotificationSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  void openBiometric() async {
    if (await BiometricManager.shared.isAvailable) {
      final enabled = await AppRoute.toBiometricEnable();
      if (enabled == null) return;
      isBiometricEnabled.value = HelperManager.isEnabledBiometricPin;
      refresh();
    } else {
      showError(
        text: 'Таны Face Id, Finger Id тохиргоо хаалттай байна',
      );
    }
  }

  void disableBiometric() async {
    if (await BiometricManager.shared.isAvailable) {
      final value = await BiometricManager.shared.checkAuthenticate();
      if (value.success) {
        await BiometricManager.shared.deleteBiometric();
        isBiometricEnabled.value = HelperManager.isEnabledBiometricPin;
        refresh();
      } else {
        showError(text: value.errorMessage);
      }
    } else {
      showError(text: 'Таны Face Id, Finger Id тохиргоо хаалттай байна');
    }
  }

  void onTapItem(MenuTabItemType type, bool? value) {
    switch (type) {
      case MenuTabItemType.employeeCard:
        MenuRoute.toEmployeeCardPage();
        break;
      case MenuTabItemType.giftCard:
        MenuRoute.toGiftCards();
        break;
      case MenuTabItemType.pointHistory:
        MenuRoute.toPointHistory();
        break;
      case MenuTabItemType.buyHistory:
        MenuRoute.toPurchaseHistory();
        break;
      case MenuTabItemType.myFinance:
        MenuRoute.toMyFinance();
        break;
      case MenuTabItemType.pinChange:
        MenuRoute.toPinChangeOld();
        break;
      case MenuTabItemType.biometric:
        if (value == null) break;
        if (value) {
          openBiometric();
        } else {
          disableBiometric();
        }
        break;
      case MenuTabItemType.notification:
        if (value == null) break;
        openNotificationSettings();
        break;
      case MenuTabItemType.ebarimt:
        MenuRoute.toEbarimt();
        break;
      case MenuTabItemType.contact:
        MenuRoute.toContact();
        break;
      case MenuTabItemType.faq:
        MenuRoute.toFaq();
        break;
      case MenuTabItemType.branch:
        MenuRoute.toBranch();
        break;
      case MenuTabItemType.terms:
        MenuRoute.toTerms();
        break;
      case MenuTabItemType.policy:
        MenuRoute.toPolicy();
        break;
    }
  }

  Future isEnabledNotification() async {
    isNotificationEnabled.value = await Permission.notification.isGranted;
    refresh();
  }

  Future onTapLogout() async {
    final confirm = await IODialogWarning(
      title: 'Та системээс гарахдаа итгэлтэй байна уу?',
    ).show();

    if (confirm == null) return;

    await UserStoreManager.shared.deleteStore();
    Get.offAllNamed(IOPages.initial);
  }
}
