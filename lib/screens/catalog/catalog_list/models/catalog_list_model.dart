import 'package:carrefour/library/library.dart';
import 'package:g_json/g_json.dart';

class CatalogListModel {
  final int id;
  final String name;
  final String thumbnail;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String pdf;
  final int orderValue;

  String get thumbnailUrl => domain + thumbnail;
  String get pdfUrl => domain + pdf;
  String get startToEnd =>
      '${startDate.toFormattedString(format: 'MM/dd')} - ${endDate.toFormattedString(format: 'MM/dd')}';

  CatalogListModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        thumbnail = json['thumbnail'].stringValue,
        description = json['description'].stringValue,
        startDate = json['start_date'].stringValue.toDate,
        endDate = json['end_date'].stringValue.toDate,
        isActive = json['is_active'].booleanValue,
        pdf = json['pdf'].stringValue,
        orderValue = json['order_value'].integerValue;
}
