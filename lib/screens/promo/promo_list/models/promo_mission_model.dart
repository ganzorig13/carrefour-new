import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';

class PromoMissionModel {
  final PromoProductModel product;
  final int totalQty;
  final int currentQty;
  final bool isBought;

  PromoMissionModel.fromJson(JSON json)
      : product = PromoProductModel.fromJson(json['product']),
        totalQty = json['total_qty'].integerValue,
        currentQty = json['current_qty'].integerValue,
        isBought = json['is_bought'].booleanValue;
}
