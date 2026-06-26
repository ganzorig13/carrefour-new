import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carrefour/library/library.dart';

class IOSwitchWidget extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  const IOSwitchWidget({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: IOColors.strokePrimary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: IOStyles.body2Medium,
          ),
          SizedBox(
            width: 42,
            child: Transform.scale(
              scale: 0.8,
              child: IOSwitch(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
