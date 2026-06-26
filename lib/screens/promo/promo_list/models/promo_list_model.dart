import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

enum PromoType { survey, progress, step, point, none }

class PromoListModel {
  final int id;
  final String name;
  final String photo;
  final PromoType progressType;
  final String startDate;
  final String endDate;
  final String ruleType;
  final String tag;
  final bool isPointReward;
  final int stepMax;
  final int stepCurrent;
  final double purchaseAmount;
  final double purchaseCurrent;
  final double pointAmount;
  final PromoSurveyModel survey;
  final bool isCompleted;

  String get endValue => '${endDate.toFormattedString(format: 'MM/dd')} хүртэл';

  PromoListModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        photo = domain + json['photo'].stringValue,
        progressType = switch (json['progress_type'].stringValue) {
          'survey' => PromoType.survey,
          'percent' => PromoType.progress,
          'step' => PromoType.step,
          'point_amount' => PromoType.point,
          _ => PromoType.none,
        },
        startDate = json['start_date'].stringValue,
        endDate = json['end_date'].stringValue,
        ruleType = json['rule_type'].stringValue,
        tag = json['tag'].stringValue,
        stepMax = json['step_max'].integerValue,
        stepCurrent = json['step_current'].integerValue,
        purchaseAmount = json['purchase_amount'].ddoubleValue,
        purchaseCurrent = json['purchase_current'].ddoubleValue,
        pointAmount = json['point_amount'].ddoubleValue,
        isCompleted = json['is_completed'].booleanValue,
        isPointReward = json['is_point_reward'].booleanValue,
        survey = PromoSurveyModel.fromJson(json['survey']);
}

class PromoSurveyModel {
  final int id;
  final List<PromoQuestionModel> questions;

  bool get isValid => questions.where((e) => !e.isValid).isEmpty;

  PromoSurveyModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        questions = json['questions']
            .listValue
            .map((e) => PromoQuestionModel.fromJson(e))
            .toList();
}

class PromoQuestionModel {
  final int id;
  final String value;
  final String photo;
  final List<PromoAnswerModel> answers;
  final PromoQuestionType questionType;
  final Axis answerDirection;

  String get photoUrl => domain + photo;
  bool get isValid => answers.where((e) => e.selected).isNotEmpty;

  PromoQuestionModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        value = json['value'].stringValue,
        photo = json['photo'].stringValue,
        answerDirection = switch (json['answer_direction'].stringValue) {
          'horizontal' => Axis.horizontal,
          'vertical' => Axis.vertical,
          _ => Axis.horizontal,
        },
        questionType = switch (json['question_type'].stringValue) {
          'single' => PromoQuestionType.single,
          'multiple' => PromoQuestionType.multiple,
          _ => PromoQuestionType.none,
        },
        answers = json['answers']
            .listValue
            .map((e) => PromoAnswerModel.fromJson(e))
            .toList();

  Map<String, dynamic> toMap() => {
        'question_id': id,
        'answers':
            answers.where((e) => e.selected).map((e) => e.toMap()).toList(),
      };
}

class PromoAnswerModel {
  final int id;
  final String value;
  bool selected = false;

  PromoAnswerModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        value = json['value'].stringValue;

  Map<String, dynamic> toMap() => {
        'answer_id': id,
      };
}

enum PromoQuestionType { single, multiple, none }
