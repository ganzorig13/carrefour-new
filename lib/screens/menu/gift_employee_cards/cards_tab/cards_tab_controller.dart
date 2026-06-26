import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class CardsTabController extends IOController {
  final titleText = 'Картнууд';
  final allCards = <GiftCardsModel>[].obs;

  GiftCardsModel? get employeeCard =>
      allCards.firstWhereOrNull((e) => e.isEmployeeCard);

  /// Бэлгийн картууд (ажилтны карт биш, үлдэгдэлтэй)
  List<GiftCardsModel> get giftCards => allCards
      .where((e) => e.isEmployeeCard == false)
      .where((e) => e.balance != 0)
      .toList();

  /// Ашигласан картууд (идэвхгүй)
  List<GiftCardsModel> get usedCards => allCards
      .where((e) => e.activated == false && e.isEmployeeCard == false)
      .toList();

  List<GiftCardsModel> get filteredCards => allCards.where((e) {
        final isEmployee = e.isEmployeeCard;
        final isGiftCardWithBalance = !e.isEmployeeCard && e.balance > 0;
        return isEmployee || isGiftCardWithBalance;
      }).toList();

  // List<GiftCardsModel> get filteredCards =>
  //     allCards.where((e) => e.isEmployeeCard).toList();

  @override
  void onInit() {
    super.onInit();
    getGiftCards();
  }

  Future getGiftCards() async {
    isInitialLoading.value = true;
    final response = await CustomerApi().giftCards();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      allCards.value = response.json['gift_cards'].listValue
          .map((e) => GiftCardsModel.fromJson(e))
          .toList();
    } else {
      showError(text: response.msg);
    }
  }
}
