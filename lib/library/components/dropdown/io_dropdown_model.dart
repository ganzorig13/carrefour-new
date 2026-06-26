import 'package:carrefour/library/library.dart';

class IODropdownModel<T> extends IOTextfieldModel {
  @override
  bool get readOnly => true;

  T? get dropdownValue => dropdownItem?.value;

  final String sheetTitle;
  IODropdownSheetModel<T>? dropdownItem;

  IODropdownModel({
    required super.label,
    required super.placeholder,
    required this.sheetTitle,
    super.isEnabled,
    super.validators,
    super.hasTitle,
  });

  void setValue(IODropdownSheetModel<T>? item) {
    dropdownItem = item;
    controller.text = item?.name ?? '';
  }
}
