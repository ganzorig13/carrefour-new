import 'package:carrefour/library/library.dart';
import 'package:carrefour/main_controller.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/widgets/employee_gift_qr_dialog.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends IOController {
  final main = Get.find<MainController>();
  final refreshController = RefreshController();
  final bannerItems = <PromoBannerModel>[].obs;
  final promoBannerItems = <PromoBannerModel>[].obs;
  final catalogItems = <CatalogListModel>[].obs;
  final promoItems = <PromoListModel>[].obs;
  final giftCards = Get.put(CardsTabController());

  final qrCode = ''.obs;

  final balance = ''.obs;

  final isEmployee = false.obs;

  int doneRequests = 0;

  final usingQr = IOButtonModel(
    label: 'Ашиглах',
    type: IOButtonType.secondary,
    size: IOButtonSize.tiny,
    prefixIcon: 'qr.svg',
  );

  @override
  void onInit() {
    super.onInit();
    UserStoreManager.shared.store.listenKey(kUser, (_) {
      user.value = HelperManager.user;
    });
    getData();
  }

  void onTapQrImage() async {
    Get.dialog(const HomeQrDialogWidget());
  }

  void onTapQrScan() async {
    final qr = await AppRoute.toQrScan();
    if (qr == null) return;
    QrPaySheet(qrString: qr).show();
  }

  void onTapPromoMore() {
    final tab = Get.find<TabBarController>();
    tab.onTabChanged(3);
  }

  void onTapCatalogyMore() {
    final tab = Get.find<TabBarController>();
    tab.onTabChanged(1);
  }

  void onTapPromoBanner(int onIndex) {
    AppRoute.toPromoBanner(items: promoBannerItems, index: onIndex);
  }

  void checkRequestIsdone() {
    doneRequests += 1;
    if (doneRequests == 3) {
      refreshController.refreshCompleted();
    }
  }

  Future getData() async {
    doneRequests = 0;
    getPoint();
    getHomeBanner();
    getPromoBanner();
    getCatalog();
    getPromo();
    await giftCards.getGiftCards();
  }

  Future getPoint() async {
    final response = await CustomerApi().getPoint();
    if (response.isSuccess) {
      main.point.value = response.json['balance'].ddoubleValue;
    }
  }

  Future getHomeBanner() async {
    final response = await CustomerApi().getBanner(key: 'banner');
    if (response.isSuccess) {
      bannerItems.value = response.data.listValue
          .map((e) => PromoBannerModel.fromJson(e))
          .toList();
    }
    checkRequestIsdone();
  }

  Future getPromoBanner() async {
    final response = await CustomerApi().getBanner(key: 'uramshuulal');
    if (response.isSuccess) {
      promoBannerItems.value = response.data.listValue
          .map((e) => PromoBannerModel.fromJson(e))
          .toList();
    }
    checkRequestIsdone();
  }

  Future getCatalog() async {
    final response = await CustomerApi().getCatalogList();
    if (response.isSuccess) {
      var items = response.data.listValue
          .map((e) => CatalogListModel.fromJson(e))
          .toList();
      items.sort((a, b) => a.orderValue.compareTo(b.orderValue));
      if (items.length > 5) {
        items = items.take(5).toList();
      }
      catalogItems.value = items;
    }
    checkRequestIsdone();
  }

  Future getPromo() async {
    final response = await CustomerApi().getPromoList(
      type: 'special',
    );

    if (response.isSuccess) {
      promoItems.value = response.data.listValue
          .map((e) => PromoListModel.fromJson(e))
          .toList();
    }
  }

  void onTapMore() {
    MenuRoute.toEmployeeCardPage();
  }

  void onTapUsingQr() {
    Get.dialog(EmployeeGiftQrDialog(
      amount: balance.value,
      qrString: qrCode.value,
      isEmployee: isEmployee.value,
    ));
  }
}
