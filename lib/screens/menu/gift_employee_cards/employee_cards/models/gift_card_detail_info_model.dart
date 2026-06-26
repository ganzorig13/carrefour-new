import 'package:g_json/g_json.dart';

class GiftCardDetailInfoModel {
  int? id;
  List<int>? partnerId;
  double balance;
  String? expiredDate;
  bool? activated;
  List<Orlogo> orlogo;
  List<Zarlaga> zarlaga;
  String? code;

  GiftCardDetailInfoModel.fromJson(JSON json)
      : id = json['id'].integer,
        balance = json['balance'].ddoubleValue,
        expiredDate = json['expired_date'].string,
        activated = json['activated'].boolean,
        orlogo =
            json['orlogo'].listValue.map((e) => Orlogo.fromJson(e)).toList(),
        zarlaga =
            json['zarlaga'].listValue.map((e) => Zarlaga.fromJson(e)).toList(),
        code = json['code'].stringValue;
}

class Orlogo {
  String? comment;

  double amount;
  String? date;

  Orlogo({required this.amount, this.date, this.comment});

  Orlogo.fromJson(JSON json)
      : comment = json['comment'].string,
        amount = json['amount'].ddoubleValue,
        date = json['date'].string;
}

class Zarlaga {
  String? comment;
  double amount;
  String? createDate;

  Zarlaga({this.comment, required this.amount, this.createDate});

  Zarlaga.fromJson(JSON json)
      : comment = json['comment'].string,
        amount = json['amount'].ddoubleValue,
        createDate = json['create_date'].string;
}
