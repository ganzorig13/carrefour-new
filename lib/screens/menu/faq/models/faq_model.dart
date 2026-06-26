import 'package:g_json/g_json.dart';

class FaqModel {
  final String question;
  final String answer;

  FaqModel.fromJson(JSON json)
      : question = json['question'].stringValue,
        answer = json['answer'].stringValue;
}
