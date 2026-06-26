import 'package:g_json/g_json.dart';

class ContactModel {
  final String title;
  final String value;
  final String keyword;
  final int orderValue;

  ContactModel.fromJson(JSON json)
      : title = json['title'].stringValue,
        value = json['value'].stringValue,
        keyword = json['keyword'].stringValue,
        orderValue = json['order_value'].integerValue;
}
