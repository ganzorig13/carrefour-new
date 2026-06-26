import 'package:carrefour/library/library.dart';
import 'package:g_json/g_json.dart';

class PromoBannerModel {
  final int id;
  final int orderingValue;
  final String photo;
  final String thumbnail;
  final String title;

  final String description;

  String get photoUrl => domain + photo;
  String get thumbnailUrl => domain + thumbnail;

  PromoBannerModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        orderingValue = json['ordering_value'].integerValue,
        photo = json['photo'].stringValue,
        thumbnail = json['thumbnail'].stringValue,
        title = json['title'].stringValue,
        description = json['description'].stringValue;
}
