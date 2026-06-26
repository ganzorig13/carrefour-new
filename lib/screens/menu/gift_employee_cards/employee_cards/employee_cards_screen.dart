import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/models/gift_card_detail_info_model.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/widgets/employee_card_transaction_button.dart';
import 'package:carrefour/screens/menu/gift_employee_cards/employee_cards/widgets/employee_statement_detail_widget.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmployeeCardsScreen extends StatelessWidget {
  final GiftCardsModel? card;
  const EmployeeCardsScreen({super.key, this.card});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      body: GetBuilder(
          init: EmployeeCardsController(card: card),
          autoRemove: false,
          builder: (controller) {
            return controller.card == null
                ? IOEmptyWidget()
                : Obx(
                    () => controller.isLoading.value
                        ? const IOLoading()
                        : controller.giftCartDetail.value == null
                            ? const IOEmptyWidget()
                            : Column(
                                children: [
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: _buildHeaderCard(controller),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: _buildBalanceRow(controller),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: _buildTitle(),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: _buildFilterTabs(controller),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTransactionList(controller),
                                ],
                              ),
                  );
          }),
    );
  }

  Widget _buildHeaderCard(EmployeeCardsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: IOColors.brand500,
        borderRadius: BorderRadius.circular(8),
        boxShadow: IOShadow.black8,
      ),
      height: 147,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/employee_white_logo.svg',
            width: 72,
            height: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Ажилтны карт',
            style: IOStyles.body2Bold.copyWith(color: IOColors.infoSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(EmployeeCardsController controller) {
    return IOCardWidget(
      height: 76,
      width: 400,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Үлдэгдэл:',
                      style: IOStyles.body2Regular
                          .copyWith(color: IOColors.textTertiary)),
                  Text(controller.balanceText.toString(),
                      style: IOStyles.h6.copyWith(color: IOColors.textPrimary)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IOButtonWidget(
                model: controller.qrUsing,
                onPressed: controller.qrPointUse,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Хийгдсэн гүйлгээнүүд',
        style: IOStyles.body1Bold.copyWith(color: IOColors.brand700),
      ),
    );
  }

  Widget _buildFilterTabs(EmployeeCardsController controller) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          const SizedBox(width: 16),
          ...controller.months.map(
            (e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: EmployeeCompletedTransactionButton(
                  model: e,
                  onTap: () => controller.selectFilter(e),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTransactionList(EmployeeCardsController controller) {
    return Obx(
      () => Expanded(
        child: controller.isLoading.value
            ? const IOLoading()
            : controller.filteredData.isEmpty
                ? IOEmptyWidget()
                : ListView.separated(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                    itemCount: controller.filteredData.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredData[index];
                      if (item is Zarlaga) {
                        return EmployeeStatementDetailWidget(model: item);
                      } else {
                        return EmployeeIncomeDetailWidget(model: item);
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  ),
      ),
    );
  }
}
