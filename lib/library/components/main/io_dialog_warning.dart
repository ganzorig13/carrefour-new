import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IODialogWarning extends IODialog {
  final String title;

  IODialogWarning({
    super.key,
    required this.title,
  }) : super(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'assets/icons/alert.warning.svg',
                width: 146,
                height: 132,
              ),
              const SizedBox(height: 40),
              Text(
                title,
                textAlign: TextAlign.center,
                style: IOStyles.h6.copyWith(
                  color: IOColors.brand700,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: IOButtonWidget(
                      model: IOButtonModel(
                        type: IOButtonType.secondary,
                        size: IOButtonSize.medium,
                        label: 'Тийм',
                      ),
                      onPressed: () {
                        Get.back(result: true);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: IOButtonWidget(
                      model: IOButtonModel(
                        type: IOButtonType.primary,
                        size: IOButtonSize.medium,
                        label: 'Үгүй',
                      ),
                      onPressed: Get.back,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
}
