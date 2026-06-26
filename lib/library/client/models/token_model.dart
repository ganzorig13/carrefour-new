import 'package:g_json/g_json.dart';

class TokenModel {
  final String access;
  final String refresh;
  final String accessExpiresAt;
  final String refreshExpiresAt;

  TokenModel.fromJson(JSON json)
      : access = json['access'].stringValue,
        refresh = json['refresh'].stringValue,
        accessExpiresAt = json['access_expires_at'].stringValue,
        refreshExpiresAt = json['refresh_expires_at'].stringValue;

  Map<String, dynamic> toMap() {
    return {
      'access': access,
      'refresh': refresh,
      'access_expires_at': accessExpiresAt,
      'refresh_expires_at': refreshExpiresAt,
    };
  }

  bool get isExpired {
    final now = DateTime.now();
    final expired = DateTime.parse(accessExpiresAt);
    final diffrence = expired.difference(now).inSeconds;
    return diffrence < 30;
  }
}
