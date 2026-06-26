class FinanceButtonModel {
  final String title;
  final int value;

  bool selected = false;

  FinanceButtonModel({
    required this.title,
    required this.value,
    this.selected = false,
  });
}
