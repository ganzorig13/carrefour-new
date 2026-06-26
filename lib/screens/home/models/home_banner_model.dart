import 'package:g_json/g_json.dart';

class HomeBannerModel {
  final int id;
  final int orderingValue;
  final String photo;
  final String title;

  final String description;

  HomeBannerModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        orderingValue = json['ordering_value'].integerValue,
        photo = json['photo'].stringValue,
        title = json['title'].stringValue,
        description = json['description'].stringValue;
}
