import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class QrPasswordSheet extends StatelessWidget {
  const QrPasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrPasswordController>(
        init: QrPasswordController(),
        builder: (controller) {
          return Container(
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
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: IOColors.brand500,
                      borderRadius: BorderRadius.circular(52),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/key.svg',
                      width: 32,
                      height: 32,
                      colorFilter: const ColorFilter.mode(
                        IOColors.backgroundPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Гүйлгээний нууц үг',
                      textAlign: TextAlign.center,
                      style: IOStyles.body1Bold.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Та гүйлгээний нууц үгээ оруулснаар төлбөр төлөгдөнө.',
                      textAlign: TextAlign.center,
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: IOOtpWidget(
                      model: controller.pinfield,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        });
  }

  Future<String?>? show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }
}
