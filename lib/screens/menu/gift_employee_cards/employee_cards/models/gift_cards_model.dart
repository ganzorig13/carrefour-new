import 'package:g_json/g_json.dart';

class GiftCardsModel {
  int id;
  String code;
  double balance;
  bool isEmployeeCard;
  bool activated;

  GiftCardsModel({
    required this.id,
    required this.code,
    required this.balance,
    required this.isEmployeeCard,
    required this.activated,
  });

  GiftCardsModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        code = json['code'].stringValue,
        balance = json['balance'].ddoubleValue,
        isEmployeeCard = json['is_employee_card'].booleanValue,
        activated = json['activated'].booleanValue;
}
