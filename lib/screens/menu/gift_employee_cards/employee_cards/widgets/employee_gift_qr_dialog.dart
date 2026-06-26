import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/cards_tab/cards_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EmployeeGiftQrDialog extends StatelessWidget {
  final String amount;
  final bool isEmployee;
  final String qrString;

  const EmployeeGiftQrDialog({
    super.key,
    required this.amount,
    required this.qrString,
    required this.isEmployee,
  });

  void _onDialogClose() {
    Get.find<CardsTabController>().getGiftCards();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onDialogClose();
        return false;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onDialogClose,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: IODialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEmployee ? 'Ажилтны карт' : "Бэлгийн карт",
                        style: IOStyles.body1Medium.copyWith(
                          color: IOColors.brand500,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Үлдэгдэл',
                            style: IOStyles.body2Regular.copyWith(
                              color: IOColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            amount,
                            style: IOStyles.h6.copyWith(
                              color: IOColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: IOCardWidget(
                      height: 192,
                      width: 192,
                      border: Border.all(
                        width: 2,
                        strokeAlign: 2,
                        color: IOColors.brand700,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IOCardWidget(
                          height: 160,
                          width: 160,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: QrImageView(
                              data: qrString,
                              errorCorrectionLevel: QrErrorCorrectLevel.H,
                              padding: EdgeInsets.zero,
                              version: QrVersions.auto,
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: IOColors.brand500,
                              ),
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: IOColors.brand500,
                              ),
                              embeddedImage: const AssetImage(
                                'assets/images/qr.embed.png',
                              ),
                              embeddedImageStyle: const QrEmbeddedImageStyle(
                                size: Size.square(24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'QR-г касс дээр уншуулаад \nтөлбөрөө төлөх боломжтой',
                      style: IOStyles.body1Regular.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  IOButtonWidget(
                    model: IOButtonModel(
                      label: 'Хаах',
                      type: IOButtonType.primary,
                      size: IOButtonSize.large,
                    ),
                    onPressed: _onDialogClose,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
