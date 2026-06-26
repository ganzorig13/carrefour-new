import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDialogScreen extends StatelessWidget {
  final NotificationListModel item;
  const NotificationDialogScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationDialogController>(
      init: NotificationDialogController(item: item),
      builder: (controller) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (item.photo.isNotEmpty) ...[
                  AspectRatio(
                    aspectRatio: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: IOImageNetworkWidget(
                        imageUrl: item.photoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: IOStyles.h6.copyWith(
                    color: IOColors.brand700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.body,
                  textAlign: TextAlign.center,
                  style: IOStyles.body1Regular.copyWith(
                    color: IOColors.brand700,
                  ),
                ),
                if (controller.hasAction) ...[
                  const SizedBox(height: 24),
                  IOButtonWidget(
                    model: controller.nextButton,
                    onPressed: controller.onTapNext,
                  )
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
