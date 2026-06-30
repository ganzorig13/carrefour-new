import 'package:carrefour/screens/menu/gift_employee_cards/gift_cards_detail/gift_cards_detail_binding.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class MenuRoute {
  static toProfile() {
    return Get.to(
      () => const ProfileScreen(),
      binding: ProfileBinding(),
    );
  }

  static toProfileEdit() {
    return Get.to(
      () => const ProfileEditScreen(),
      binding: ProfileEditBinding(),
    );
  }

  static toPointHistory() {
    return Get.to(
      () => const PointPageScreen(),
      binding: PointPageBinding(),
    );
  }

  static toPurchaseHistory() {
    return Get.to(
      () => const PurchaseListScreen(),
      binding: PurchaseListBinding(),
    );
  }

  static toPurchaseDetail({required PurchaseListModel item}) {
    return Get.to(
      () => const PurchaseDetailScreen(),
      binding: PurchaseDetailBinding(item: item),
    );
  }

  static toMyFinance() {
    return Get.to(
      () => const FinanceScreen(),
      binding: FinanceBinding(),
    );
  }

  static toPhoneChangeNumber() {
    return Get.to(
      () => const PhoneChangeNumberScreen(),
      binding: PhoneChangeNumberBinding(),
    );
  }

  static toChangeNumberRequest() {
    return Get.to(
      () => const SignInRecoverCustomerScreen(),
      binding: SignInRecoverCustomerBinding(),
    );
  }

  static toPhoneChangeOtp({required String phone}) {
    return Get.to(
      () => const PhoneChangeOtpScreen(),
      binding: PhoneChangeOtpBinding(phone: phone),
    );
  }

  static toPinChangeOld() {
    return Get.to(
      () => const PinChangeOldScreen(),
      binding: PinChangeOldBinding(),
    );
  }

  static toPinChangeNew(String oldPin) {
    return Get.to(
      () => const PinChangeNewScreen(),
      binding: PinChangeNewBinding(oldPin: oldPin),
    );
  }

  static toPinResetOtp() {
    return Get.to(
      () => const PinResetOtpScreen(),
      binding: PinResetOtpBinding(),
    );
  }

  static toPinResetNew({
    required String phone,
    required String token,
  }) {
    return Get.to(
      () => const PinResetNewScreen(),
      binding: PinResetNewBinding(phone: phone, token: token),
    );
  }

  static toEbarimt() {
    return Get.to(
      () => const EbarimtScreen(),
      binding: EbarimtBinding(),
    );
  }

  static toContact() {
    return Get.bottomSheet(
      const ContactSheet(),
      isScrollControlled: true,
    );
  }

  static toFaq() {
    return Get.to(
      () => const FaqScreen(),
      binding: FaqBinding(),
    );
  }

  static toBranch() {
    return Get.to(
      () => const BranchScreen(),
      binding: BranchBinding(),
    );
  }

  static toTerms() {
    return Get.to(
      () => const TermsScreen(),
      binding: TermsBinding(),
    );
  }

  static toPolicy() {
    return Get.to(
      () => const PolicyScreen(),
      binding: PolicyBinding(),
    );
  }

  static toWebview({required String title, required String url}) {
    return Get.to(
      () => const WebviewScreen(),
      binding: WebviewBinding(title: title, urlString: url),
    );
  }

  static toEmployeeCardPage() {
    return Get.to(
      () => const CardsTabScreen(),
      binding: CardsTabBinding(),
    );
  }

  static toGiftCards() {
    return Get.to(
      () => const CardsTabScreen(initialIndex: 1),
      binding: CardsTabBinding(),
    );
  }

  static toCardDetailScreen({required GiftCardsModel item}) {
    return Get.to(
      () => GiftCardsDetailScreen(item: item),
      binding: GiftCardsDetailBinding(item: item),
    );
  }

  static toGiftCardQrScan() {
    return Get.to(
      const GiftCardsQrScanScreen(),
      binding: GiftCardsQrScanBinding(),
      fullscreenDialog: true,
    );
  }
}
