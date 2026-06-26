import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

enum PromoRewardStatus {
  active(
    title: 'Идэвхитэй',
    foregroundColor: IOColors.successPrimary,
    backgroundColor: IOColors.successSecondary,
  ),
  claimed(
    title: 'Ашигласан',
    foregroundColor: IOColors.errorPrimary,
    backgroundColor: IOColors.errorSecondary,
  ),
  notActive(
    title: 'Идэвхигүй',
    foregroundColor: IOColors.textPrimary,
    backgroundColor: IOColors.backgroundQuarternary,
  );

  const PromoRewardStatus({
    required this.title,
    required this.foregroundColor,
    required this.backgroundColor,
  });
  final String title;
  final Color foregroundColor;
  final Color backgroundColor;
}

class PromoRewardModel {
  final int id;
  final String name;
  final String photo;
  final String rewardType;
  final int rewardPoint;
  final String rewardQr;
  final String state;
  final int qnty;

  String get rewardQrRepaced => rewardQr.replaceAll("'", '"');

  PromoRewardStatus get status => switch (state) {
        'not_active' => PromoRewardStatus.notActive,
        'claimed' => PromoRewardStatus.claimed,
        'active' => PromoRewardStatus.active,
        _ => PromoRewardStatus.notActive,
      };

  PromoRewardModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        photo = domain + json['photo'].stringValue,
        rewardType = json['reward_type'].stringValue,
        rewardPoint = json['reward_point'].integerValue,
        rewardQr = json['reward_qr'].stringValue,
        state = json['state'].stringValue,
        qnty = json['products']['qty'].integerValue;
}
