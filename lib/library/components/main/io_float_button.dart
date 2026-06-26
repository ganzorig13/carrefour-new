import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOFloatActionButton extends FloatingActionButton {
  IOFloatActionButton({
    super.key,
    required super.onPressed,
    required super.child,
  }) : super(
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: IOColors.brand500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
}

// FloatingActionButton(
//         onPressed: controller.onAddApartment,
//         elevation: 0,
//         highlightElevation: 0,
//         backgroundColor: IOColors.brand500,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: const Icon(
//           Icons.add,
//           color: IOColors.backgroundPrimary,
//         ),
//       )