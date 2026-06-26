import 'package:carrefour/library/client/api/customer_api.dart';
import 'package:carrefour/library/components/components.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_card_detail_info_model.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_cards_model.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/widgets/employee_gift_qr_dialog.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class GiftCardsDetailController extends IOController {
  final GiftCardsModel item;

  GiftCardsDetailController({required this.item});

  final giftCartDetail = Rxn<GiftCardDetailInfoModel>();

  final usingQr = IOButtonModel(
    label: 'Ашиглах',
    type: IOButtonType.secondary,
    size: IOButtonSize.small,
    prefixIcon: 'qr.svg',
  );
  @override
  void onInit() async {
    super.onInit();
    await getData(item);
  }

  Future<void> getData(GiftCardsModel item) async {
    isLoading.value = true;
    final response =
        await CustomerApi().giftCardDetail(code: item.code, type: '');
    isLoading.value = false;

    if (response.isSuccess) {
      giftCartDetail.value =
          GiftCardDetailInfoModel.fromJson(JSON(response.json['gift_card']));
    } else {
      showError(text: response.msg);
    }
  }

  Future<void> usingQrButton(code, balance) async {
    await Get.dialog(EmployeeGiftQrDialog(
      amount: balance,
      qrString: code,
      isEmployee: false,
    ));
  }
}
