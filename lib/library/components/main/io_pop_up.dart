import 'package:carrefour/library/theme/io_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IOPopup extends StatelessWidget {
  final List<Widget> children;
  final double borderRadius;
  final Color backgroundColor;
  final CrossAxisAlignment crossAxisAlignment;
  final double marginPadding;
  final double horizontalPadding;
  final double verticalPadding;
  const IOPopup({
    super.key,
    required this.children,
    this.borderRadius = 16,
    this.backgroundColor = IOColors.backgroundImage,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.marginPadding = 24,
    this.horizontalPadding = 20,
    this.verticalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: marginPadding),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }

  void dismiss() {
    Get.back();
  }

  Future<bool?> show() {
    return Get.generalDialog(
      barrierLabel: 'label',
      barrierDismissible: true,
      pageBuilder: (context, a1, a2) {
        return this;
      },
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 300), end: Offset.zero)
              .animate(a1),
          child: child,
        );
      },
    );
  }
}
