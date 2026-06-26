import 'package:carrefour/library/library.dart';
import 'package:g_json/g_json.dart';

class PromoProductModel {
  final int id;
  final String name;
  final String code;
  final String photo;

  PromoProductModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        code = json['code'].stringValue,
        photo = domain + json['photo'].stringValue;
}
