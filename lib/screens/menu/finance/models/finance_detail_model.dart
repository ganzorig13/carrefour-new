import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

class FinanceDetailModel {
  final String categoryName;
  final String categoryId;
  final double totalAmount;
  final String icon;
  final String color;

  String get iconUrl => domain + icon;
  Color get colorValue => color.toHexColor();

  FinanceDetailModel.fromJson(JSON json)
      : categoryName = json['category_name'].stringValue,
        categoryId = json['category_id'].stringValue,
        totalAmount = json['total_amount'].ddoubleValue,
        icon = json['icon'].stringValue,
        color = json['color'].stringValue;
}
