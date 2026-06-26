import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PurchaseDetailScreen extends GetView<PurchaseDetailController> {
  const PurchaseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: IOCardWidget(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 42,
                      height: 32,
                      child: Image.asset(
                        'assets/icons/ebarimt.png',
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Таны баримт',
                            style: IOStyles.body2Bold,
                          ),
                          Text(
                            controller.item.dateOrder,
                            style: IOStyles.caption1Regular.copyWith(
                              color: IOColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 42,
                      height: 32,
                      child: SvgPicture.asset(
                        'assets/icons/logo.svg',
                        alignment: Alignment.centerRight,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = controller.item.items[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: IOStyles.caption2Regular.copyWith(
                            color: IOColors.textSecondary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          item.qnty,
                          textAlign: TextAlign.right,
                          style: IOStyles.caption2Regular.copyWith(
                            color: IOColors.textSecondary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          item.priceUnit.toCurrency(),
                          textAlign: TextAlign.right,
                          style: IOStyles.caption2Regular.copyWith(),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          item.totalAmount.toCurrency(),
                          textAlign: TextAlign.right,
                          style: IOStyles.caption2Regular.copyWith(),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemCount: controller.item.items.length,
              ),
              const Divider(
                height: 48,
                thickness: 1,
                color: IOColors.strokePrimary,
              ),
              PurchaseDetailRowWidget(
                title: 'Нийт',
                value: controller.item.totalAmount.toCurrency(),
              ),
              const SizedBox(height: 8),
              PurchaseDetailRowWidget(
                title: 'Цуглуулсан оноо',
                value: controller.item.loyaltyCollect.toCurrency(
                  hasSymbol: false,
                ),
              ),
              const SizedBox(height: 8),
              PurchaseDetailRowWidget(
                title: 'Зарцуулсан оноо',
                value: controller.item.loyaltySpend.toCurrency(
                  hasSymbol: false,
                ),
              ),
              const SizedBox(height: 8),
              PurchaseDetailRowWidget(
                title: 'Үлдэгдэл оноо',
                value: controller.item.loyaltyBalance.toCurrency(
                  hasSymbol: false,
                ),
              ),
              const SizedBox(height: 8),
              PurchaseDetailRowWidget(
                title: 'И-Баримтанд бүртгүүлэх дүн',
                value: controller.item.ebarimtAmount.toCurrency(),
              ),
              const SizedBox(height: 8),
              PurchaseDetailRowWidget(
                title: controller.item.text['text1'] ?? 'Суглааны дугаар',
                value: controller.item.vatLottery,
              ),
              if (controller.item.loyaltyNo.isNotEmpty) ...[
                const SizedBox(height: 16),
                PurchaseDetailRowWidget(
                  title: controller.item.text['text2'] ?? 'Урамшууллын дугаар',
                  value: controller.item.loyaltyNo,
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'Таны И- Баримт',
                style: IOStyles.body2Medium,
              ),
              const SizedBox(height: 12),
              SizedBox.square(
                dimension: 140,
                child: QrImageView(
                  data: controller.item.vatQrData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
