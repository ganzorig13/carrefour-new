import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_card_detail_info_model.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/widgets/employee_gift_qr_dialog.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class EmployeeCardsController extends IOController {
  final GiftCardsModel? card;
  final giftCartDetail = Rxn<GiftCardDetailInfoModel>();
  final selectedFilter = 1.obs;

  final qrUsing = IOButtonModel(
    label: 'Ашиглах',
    size: IOButtonSize.small,
    type: IOButtonType.secondary,
    prefixIcon: 'qr.svg',
  );

  final months = [
    EmployeeCardTransactionModel(title: 'Бүгд', value: 1, selected: true),
    EmployeeCardTransactionModel(title: 'Орлого', value: 2),
    EmployeeCardTransactionModel(title: 'Зарлага', value: 3),
  ].obs;

  EmployeeCardsController({required this.card});

  List<dynamic> get filteredData {
    final detail = giftCartDetail.value;
    if (detail == null) return [];
    switch (selectedFilter.value) {
      case 2:
        return detail.orlogo;
      case 3:
        return detail.zarlaga;
      case 1:
      default:
        return [...detail.orlogo, ...detail.zarlaga];
    }
  }

  String? get balanceText => giftCartDetail.value?.balance.toCurrency();
  String? get code => giftCartDetail.value?.code;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void selectFilter(EmployeeCardTransactionModel model) {
    selectedFilter.value = model.value;
    for (var element in months) {
      element.selected.value = element == model;
    }
  }

  void qrPointUse() {
    Get.dialog(EmployeeGiftQrDialog(
      amount: balanceText!,
      qrString: code.toString(),
      isEmployee: true,
    ));
  }

  Future<void> getData() async {
    final code = card?.code;
    if (code == null) return;
    isLoading.value = true;
    final response = await CustomerApi().giftCardDetail(code: code, type: '');
    isLoading.value = false;

    if (response.isSuccess) {
      giftCartDetail.value =
          GiftCardDetailInfoModel.fromJson(response.json['gift_card']);
    } else {
      showError(text: response.msg);
    }
  }
}
