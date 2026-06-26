import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carrefour/library/library.dart';

class IOTextfieldModel {
  final String label;
  final String placeholder;
  final TextInputType keyboardType;
  final List<ValidatorType>? validators;
  final List<TextInputFormatter>? inputFormatters;
  bool hasTitle = true;
  bool hasBorder = false;
  bool isSecure = false;
  bool isEnabled = true;
  bool readOnly = false;
  int? maxLength;
  int maxLine = 1;

  IOTextfieldModel({
    required this.label,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.hasTitle = true,
    this.hasBorder = false,
    this.isSecure = false,
    this.isEnabled = true,
    this.readOnly = false,
    this.validators,
    this.inputFormatters,
    this.maxLength,
    this.maxLine = 1,
  });

  final focusNode = FocusNode();
  final controller = TextEditingController();
  final status = ValueNotifier(IOTextfieldStatusModel());

  String get value => controller.text;
  bool get isValid => status.value.isValid;
}

class IOTextfieldStatusModel {
  IOTextfieldStatus status;
  String? descriptionText;

  bool get isValid {
    return status == IOTextfieldStatus.success;
  }

  bool get hasText {
    return descriptionText != null;
  }

  IOTextfieldStatusModel({
    this.status = IOTextfieldStatus.normal,
    this.descriptionText,
  });
}

enum IOTextfieldStatus {
  normal,
  error,
  success,
}
