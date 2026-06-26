import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

class IOButtonModel extends IOButtonMainModel {
  IOButtonModel({
    required super.label,
    required super.type,
    required super.size,
    super.isLoading = false,
    super.isEnabled = true,
    super.isExpanded = false,
    super.borderRadius,
    super.prefixIcon,
    super.suffixIcon,
    super.enabledBackgroundColor,
    super.disabledBackgroundColor,
    super.enabledForegroundColor,
    super.disabledForegroundColor,
    super.focusedBackgroundColor,
  }) : super(
          onlyIcon: false,
          icon: '',
        );
}

class IOButtonIconModel extends IOButtonMainModel {
  IOButtonIconModel({
    required super.icon,
    required super.type,
    required super.size,
    super.isLoading = false,
    super.isEnabled = true,
    super.borderRadius,
    super.enabledBackgroundColor,
    super.disabledForegroundColor,
    super.focusedBackgroundColor,
    super.enabledForegroundColor,
  }) : super(
          onlyIcon: true,
          label: '',
        );
}

abstract class IOButtonMainModel {
  String label;
  final IOButtonType type;
  final IOButtonSize size;
  bool isLoading = false;
  bool isEnabled = true;
  bool isExpanded = false;
  final bool onlyIcon;
  final String icon;
  final double borderRadius;
  String? suffixIcon;
  String? prefixIcon;
  final Color? enabledBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledForegroundColor;
  final Color? focusedBackgroundColor;

  bool get hasPrefix {
    return prefixIcon != null;
  }

  bool get hasSuffix {
    return suffixIcon != null;
  }

  Color get backgroundColor => isEnabled
      ? enabledBackgroundColor ?? type.enabledBackgroundColor
      : disabledBackgroundColor ?? type.disabledBackgroundColor;
  Color get foregroundColor => isEnabled
      ? enabledForegroundColor ?? type.enabledForegroundColor
      : disabledForegroundColor ?? type.disabledForegroundColor;
  Color get borderColor =>
      isEnabled ? type.enabledBorderColor : type.disabledBorderColor;
  Color get fBackgroundColor =>
      focusedBackgroundColor ?? type.focusedBackgroundColor;

  IOButtonMainModel({
    required this.label,
    required this.type,
    required this.size,
    required this.onlyIcon,
    required this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isExpanded = false,
    this.borderRadius = 8,
    this.prefixIcon,
    this.suffixIcon,
    this.enabledBackgroundColor,
    this.disabledBackgroundColor,
    this.enabledForegroundColor,
    this.disabledForegroundColor,
    this.focusedBackgroundColor,
  });
}

enum IOButtonType {
  primary(
    enabledBackgroundColor: IOColors.brand500,
    enabledForegroundColor: IOColors.backgroundPrimary,
    enabledBorderColor: Colors.transparent,
    disabledBackgroundColor: IOColors.backgroundQuarternary,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: Colors.transparent,
    focusedBackgroundColor: IOColors.brand700,
    focusedForegroundColor: IOColors.backgroundPrimary,
    focusedBorderColor: Colors.transparent,
  ),

  secondary(
    enabledBackgroundColor: IOColors.brand50,
    enabledForegroundColor: IOColors.brand500,
    enabledBorderColor: Colors.transparent,
    disabledBackgroundColor: IOColors.backgroundQuarternary,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: Colors.transparent,
    focusedBackgroundColor: IOColors.brand100,
    focusedForegroundColor: IOColors.textPrimary,
    focusedBorderColor: Colors.transparent,
  ),
  oulineBrand(
    enabledBackgroundColor: Colors.transparent,
    enabledForegroundColor: IOColors.brand500,
    enabledBorderColor: IOColors.brand500,
    disabledBackgroundColor: Colors.transparent,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: IOColors.strokeTertiary,
    focusedBackgroundColor: IOColors.brand50,
    focusedForegroundColor: IOColors.brand700,
    focusedBorderColor: IOColors.brand700,
  ),
  oulineGray(
    enabledBackgroundColor: Colors.transparent,
    enabledForegroundColor: IOColors.textPrimary,
    enabledBorderColor: IOColors.strokePrimary,
    disabledBackgroundColor: Colors.transparent,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: IOColors.strokeTertiary,
    focusedBackgroundColor: IOColors.backgroundQuarternary,
    focusedForegroundColor: IOColors.textPrimary,
    focusedBorderColor: IOColors.strokePrimary,
  ),
  textBrand(
    enabledBackgroundColor: Colors.transparent,
    enabledForegroundColor: IOColors.brand500,
    enabledBorderColor: Colors.transparent,
    disabledBackgroundColor: Colors.transparent,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: Colors.transparent,
    focusedBackgroundColor: IOColors.brand50,
    focusedForegroundColor: IOColors.brand600,
    focusedBorderColor: Colors.transparent,
  ),
  textGray(
    enabledBackgroundColor: Colors.transparent,
    enabledForegroundColor: IOColors.textPrimary,
    enabledBorderColor: Colors.transparent,
    disabledBackgroundColor: Colors.transparent,
    disabledForegroundColor: IOColors.textTertiary,
    disabledBorderColor: Colors.transparent,
    focusedBackgroundColor: IOColors.backgroundQuarternary,
    focusedForegroundColor: IOColors.textPrimary,
    focusedBorderColor: Colors.transparent,
  );

  final Color enabledBackgroundColor;
  final Color enabledForegroundColor;
  final Color enabledBorderColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final Color disabledBorderColor;
  final Color focusedBackgroundColor;
  final Color focusedForegroundColor;
  final Color focusedBorderColor;

  const IOButtonType({
    required this.enabledBackgroundColor,
    required this.enabledForegroundColor,
    required this.enabledBorderColor,
    required this.disabledBackgroundColor,
    required this.disabledForegroundColor,
    required this.disabledBorderColor,
    required this.focusedBackgroundColor,
    required this.focusedForegroundColor,
    required this.focusedBorderColor,
  });
}

enum IOButtonSize {
  large(
    height: 56,
    iconSize: 24,
    separator: 12,
    style: IOStyles.button56,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
  ),
  medium(
    height: 48,
    iconSize: 24,
    separator: 12,
    style: IOStyles.button56,
    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 0),
  ),
  small(
    height: 40,
    iconSize: 16,
    separator: 8,
    style: IOStyles.button40,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  ),
  tiny(
    height: 32,
    iconSize: 16,
    separator: 4,
    style: IOStyles.button32,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
  );

  final double height;
  final double iconSize;
  final double separator;
  final TextStyle style;
  final EdgeInsetsGeometry padding;

  const IOButtonSize({
    required this.height,
    required this.iconSize,
    required this.separator,
    required this.style,
    required this.padding,
  });
}
