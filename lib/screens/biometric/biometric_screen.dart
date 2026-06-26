import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BiometricScreen extends GetView<BiometricController> {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                width: 150,
                child: AspectRatio(
                  aspectRatio: 145 / 168,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/icons/empty.background.svg',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/face.svg',
                        width: 32,
                        height: 32,
                        colorFilter: const ColorFilter.mode(
                          IOColors.brand400,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                controller.titleText,
                textAlign: TextAlign.center,
                style: IOStyles.h6.copyWith(
                  color: IOColors.brand700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                controller.bodyText,
                textAlign: TextAlign.center,
                style: IOStyles.body1Regular.copyWith(
                  color: IOColors.brand700,
                ),
              ),
              const Spacer(flex: 4),
              Row(
                children: [
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.declineButton,
                      onPressed: controller.onTapDecline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.acceptButton,
                      onPressed: controller.onTapAccept,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
