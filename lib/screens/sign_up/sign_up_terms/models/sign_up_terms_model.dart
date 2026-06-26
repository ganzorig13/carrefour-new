import 'package:g_json/g_json.dart';

class SignUpTermsModel {
  final String title;
  final String description;

  SignUpTermsModel.fromJson(JSON json)
      : title = json['title'].stringValue,
        description = json['description'].stringValue;
}
