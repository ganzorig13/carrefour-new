import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final double? width;
  final double? height;
  const IOCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.alignment,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor ?? IOColors.backgroundPrimary,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        boxShadow: IOShadow.black8,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: child,
      ),
    );
  }
}
