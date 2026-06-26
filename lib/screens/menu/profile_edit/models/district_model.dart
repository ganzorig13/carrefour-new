import 'package:g_json/g_json.dart';

class DistrictModel {
  final int id;
  final String name;

  DistrictModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue;
}
