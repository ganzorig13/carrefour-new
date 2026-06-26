import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class QrPaySheet extends StatelessWidget {
  final String qrString;
  const QrPaySheet({super.key, required this.qrString});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrPayController>(
        init: QrPayController(qrString: qrString),
        builder: (controller) {
          return Obx(
            () => Container(
              decoration: const BoxDecoration(
                color: IOColors.backgroundPrimary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: IOColors.textQuarternary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Төлөх дүн',
                        textAlign: TextAlign.center,
                        style: IOStyles.body1Bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.payAmount.value.toCurrency(),
                            textAlign: TextAlign.center,
                            style: IOStyles.h1.copyWith(
                              color: IOColors.brand500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                width: 1,
                                color: IOColors.strokePrimary,
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/logo.svg',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: IOButtonWidget(
                        model: controller.payButton.value,
                        onPressed: controller.onTapPay,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }
}
