import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class FinanceChartWidget extends StatelessWidget {
  final double amount;
  final List<FinanceDetailModel> items;
  const FinanceChartWidget({
    super.key,
    required this.amount,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Нийт зарлага',
                    style: IOStyles.caption1Medium.copyWith(
                      color: IOColors.textSecondary,
                    ),
                  ),
                  Text(
                    amount.toCurrency(),
                    style: IOStyles.body1Bold.copyWith(
                      color: IOColors.brand700,
                    ),
                  ),
                ],
              ),
            ),
            SfCircularChart(series: <CircularSeries>[
              DoughnutSeries<FinanceDetailModel, String>(
                enableTooltip: true,
                radius: '100%',
                innerRadius: '60%',
                dataSource: items,
                pointColorMapper: (data, _) => data.colorValue,
                xValueMapper: (data, _) => data.categoryName,
                yValueMapper: (data, _) => data.totalAmount,

                dataLabelMapper: (data, index) {
                  final percent = (data.totalAmount / amount) * 100;
                  return '${percent.toStringAsFixed(1)}%';
                },
                // dataLabelSettings: DataLabelSettings(
                //   isVisible: true,
                //   showZeroValue: false,
                //   useSeriesColor: true,
                //   labelIntersectAction: LabelIntersectAction.shift,
                //   labelPosition: ChartDataLabelPosition.outside,
                //   textStyle: IOStyles.caption1Medium,
                //   connectorLineSettings: ConnectorLineSettings(
                //     type: ConnectorType.curve,
                //   ),
                // ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
