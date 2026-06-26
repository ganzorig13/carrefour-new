import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:carrefour/library/library.dart';

class IOAlert extends StatelessWidget {
  final IOAlertType type;
  final String? icon;
  final String? titleText;
  final String bodyText;
  final String? acceptText;
  final String? cancelText;

  final bool dismissable;
  const IOAlert({
    super.key,
    required this.type,
    required this.bodyText,
    this.icon,
    this.dismissable = true,
    this.titleText,
    this.acceptText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: IOColors.backgroundPrimary,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              icon ?? type.image,
              width: 146,
              height: 132,
            ),
            const SizedBox(height: 40),
            Text(
              titleText ?? type.text,
              textAlign: TextAlign.center,
              style: IOStyles.h6.copyWith(
                color: IOColors.brand700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              bodyText,
              maxLines: 15,
              textAlign: TextAlign.center,
              style: IOStyles.body1Regular.copyWith(
                color: IOColors.brand700,
              ),
            ),
            if (acceptText != null || cancelText != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  children: [
                    if (cancelText != null)
                      Expanded(
                        child: IOButtonWidget(
                          onPressed: Get.back,
                          model: IOButtonModel(
                            label: cancelText ?? 'Үгүй',
                            type: IOButtonType.secondary,
                            size: IOButtonSize.medium,
                          ),
                        ),
                      ),
                    if (acceptText != null && cancelText != null)
                      const SizedBox(width: 16),
                    if (acceptText != null)
                      Expanded(
                        child: IOButtonWidget(
                          onPressed: () => Get.back(result: true),
                          model: IOButtonModel(
                            label: acceptText ?? 'Тийм',
                            type: IOButtonType.primary,
                            size: IOButtonSize.medium,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            // if (buttonText != null) ...[
            //   const SizedBox(height: 40),
            //   IOButtonWidget(
            //     model: IOButtonModel(
            //       type: IOButtonType.primary,
            //       size: IOButtonSize.medium,
            //       label: buttonText ?? '',
            //     ),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  Future<bool?> show() async {
    return Get.dialog(
      this,
      barrierDismissible: dismissable,
    );
  }
}

enum IOAlertType {
  success(
    text: 'Амжилттай',
    image: 'assets/icons/alert.success.svg',
  ),
  warning(
    text: 'Анхаарна уу',
    image: 'assets/icons/alert.warning.svg',
  );

  const IOAlertType({required this.text, required this.image});

  final String text;
  final String image;
}
