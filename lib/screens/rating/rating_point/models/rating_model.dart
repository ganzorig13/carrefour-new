import 'package:g_json/g_json.dart';

class RatingModel {
  final int id;
  final String title;
  final String description;
  final String question;

  final List<RatingAnswerModel> answerchoices;

  RatingModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        title = json['title'].stringValue,
        description = json['description'].stringValue,
        question = json['question'].stringValue,
        answerchoices = json['answerchoices']
            .listValue
            .map((e) => RatingAnswerModel.fromJson(e))
            .toList();
}

class RatingAnswerModel {
  final int id;
  final String answer;

  RatingAnswerModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        answer = json['answer'].stringValue;
}
