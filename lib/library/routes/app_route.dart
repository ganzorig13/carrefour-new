import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class AppRoute {
  static Future? toNotificationList() {
    return Get.to(
      () => const NotificationListScreen(),
      binding: NotificationListBinding(),
    );
  }

  static Future toNotificationDialog({required NotificationListModel item}) {
    return Get.dialog(NotificationDialogScreen(item: item));
  }

  static toPromoBanner({
    required List<PromoBannerModel> items,
    required int index,
  }) {
    return Get.to(
      () => const PromoBannerScreen(),
      binding: PromoBannerBinding(
        index: index,
        items: items,
      ),
      fullscreenDialog: true,
    );
  }

  static toCatalogInfo({required int catalogId}) {
    return Get.to(
      () => const CatalogInfoScreen(),
      binding: CatalogInfoBinding(catalogId: catalogId),
      fullscreenDialog: true,
    );
  }

  static Future<String?>? toPromoInfo({required int promoId}) {
    return Get.to(
      () => const PromoDetailScreen(),
      binding: PromoDetailBinding(id: promoId),
    );
  }

  static toPromoSurvey({
    required int promoId,
    required PromoListModel promo,
  }) {
    return Get.to(
      () => const PromoSurveyScreen(),
      binding: PromoSurveyBinding(
        id: promoId,
        promo: promo,
      ),
    );
  }

  static toQrImage() {
    return Get.dialog(const HomeQrDialogWidget());
  }

  static toQrScan() {
    return Get.to(
      const QrScanScreen(),
      binding: QrScanBinding(),
      fullscreenDialog: true,
    );
  }

  static toRatingPoint({required int id}) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    return Get.bottomSheet(
      RatingPointSheet(id: id),
      isScrollControlled: true,
    );
  }

  static toRatingQuestion({
    required int id,
    required int point,
    required RatingModel rateInfo,
  }) {
    return Get.bottomSheet(
      RatingQuestionSheet(id: id, point: point, rateInfo: rateInfo),
      isScrollControlled: true,
    );
  }

  static Future<bool?>? toBiometricEnable() {
    return Get.to(
      () => const BiometricScreen(),
      binding: BiometricBinding(),
      fullscreenDialog: true,
    );
  }
}
