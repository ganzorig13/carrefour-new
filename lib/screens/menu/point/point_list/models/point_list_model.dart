import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';

class PointListModel {
  final PointListType type;
  final int id;
  final String title;
  final double loyaltyCollect;
  final double loyaltySpend;
  final double loyaltyBalance;
  final String dateOrder;

  double get loyaltyValue => switch (type) {
        PointListType.collect => loyaltyCollect,
        PointListType.spend => loyaltySpend,
      };

  String get loyaltySign => switch (type) {
        PointListType.collect => '+',
        PointListType.spend => '-',
      };

  PointListModel.fromJson(JSON json, this.type)
      : id = json['id'].integerValue,
        title = json['title'].stringValue,
        loyaltyCollect = json['loyalty_collect'].ddoubleValue,
        loyaltySpend = json['loyalty_spend'].ddoubleValue,
        loyaltyBalance = json['loyalty_balance'].ddoubleValue,
        dateOrder = json['date_order'].stringValue;
}
