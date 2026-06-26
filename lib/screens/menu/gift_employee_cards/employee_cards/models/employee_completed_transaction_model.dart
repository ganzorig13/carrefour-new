import 'package:get/get_rx/src/rx_types/rx_types.dart';

class EmployeeCardTransactionModel {
  final String title;
  final int value;
  final RxBool selected;

  EmployeeCardTransactionModel({
    required this.title,
    required this.value,
    bool selected = false,
  }) : selected = selected.obs;
}
