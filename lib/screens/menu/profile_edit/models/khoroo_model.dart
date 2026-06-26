import 'package:g_json/g_json.dart';

class KhorooModel {
  final int id;
  final int district;
  final String name;

  KhorooModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        district = json['district'].integerValue,
        name = json['name'].stringValue;
}
