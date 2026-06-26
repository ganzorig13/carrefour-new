import 'package:g_json/g_json.dart';

class PurchaseListModel {
  final int id;
  final String branchNo;
  final String posNo;
  final double totalAmount;
  final double ebarimtAmount;
  final String vatBillId;
  final String vatLottery;
  final String vatQrData;
  final double loyaltyCollect;
  final double loyaltySpend;
  final double loyaltyBalance;
  final String dateOrder;
  final String loyaltyNo;
  final Map<String, String> text;
  final List<PurchaseProductModel> items;

  double get loyaltyValue {
    if (loyaltyCollect != 0) return loyaltyCollect;
    if (loyaltySpend != 0) return loyaltySpend;
    return 0;
  }

  String get loyaltySign {
    if (loyaltyCollect != 0) return '+';
    if (loyaltySpend != 0) return '-';
    return '';
  }

  PurchaseListModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        branchNo = json['branch_no'].stringValue,
        posNo = json['pos_no'].stringValue,
        totalAmount = json['total_amount'].ddoubleValue,
        ebarimtAmount = json['ebarimt_amount'].ddoubleValue,
        vatBillId = json['vat_bill_id'].stringValue,
        vatLottery = json['vat_lottery'].stringValue,
        vatQrData = json['vat_qr_data'].stringValue,
        loyaltyCollect = json['loyalty_collect'].ddoubleValue,
        loyaltySpend = json['loyalty_spend'].ddoubleValue,
        loyaltyBalance = json['loyalty_balance'].ddoubleValue,
        dateOrder = json['date_order'].stringValue,
        loyaltyNo = json['loyalty_no'].stringValue,
        text = json['status_text']
            .mapValue
            .map((key, value) => MapEntry(key, value.stringValue)),
        items = json['items']
            .listValue
            .map((e) => PurchaseProductModel.fromJson(e))
            .toList();
}

class PurchaseProductModel {
  final int id;
  final String createdAt;
  final String name;
  final String qnty;
  final double priceUnit;
  final double totalAmount;

  PurchaseProductModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        createdAt = json['created_at'].stringValue,
        name = json['name'].stringValue,
        qnty = json['qnty'].stringValue,
        priceUnit = json['price_unit'].ddoubleValue,
        totalAmount = json['total_amount'].ddoubleValue;
}
