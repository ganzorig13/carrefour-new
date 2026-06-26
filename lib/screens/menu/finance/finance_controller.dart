import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class FinanceController extends IOController {
  final titleText = 'Миний санхүү';

  final months = [
    FinanceButtonModel(title: '1 сар', value: 1, selected: true),
    FinanceButtonModel(title: '2 сар', value: 2),
    FinanceButtonModel(title: '3 сар', value: 3),
  ].obs;

  final totalAmount = 0.0.obs;
  final items = <FinanceDetailModel>[].obs;

  int get selectedMonth =>
      months.where((e) => e.selected).map((e) => e.value).first;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getOnTapMonth(FinanceButtonModel month) {
    if (month.selected) return;

    for (final item in months) {
      item.selected = item.value == month.value;
    }
    months.refresh();
    getData();
  }

  Future getData() async {
    isLoading.value = true;
    final response = await CustomerApi().getFinance(month: selectedMonth);
    isLoading.value = false;

    if (response.isSuccess) {
      totalAmount.value = response.data['total'].ddoubleValue;
      items.value = response.data['detail'].listValue
          .map((e) => FinanceDetailModel.fromJson(e))
          .toList();
    } else {
      showError(text: response.msg);
      Get.back();
    }
  }
}
