import 'package:g_json/g_json.dart';

class IOResponse {
  bool get isSuccess => success;

  bool success = false;
  String msg = '';
  JSON json = JSON.nil;
  JSON data = JSON.nil;

  IOResponse();

  IOResponse.fromJSON(JSON response) {
    success = response['success'].booleanValue;
    msg = response['msg'].stringValue;
    data = response['data'];
    json = response;
  }

  IOResponse.withError(String text) {
    success = false;
    msg = text;
  }

  IOResponse.withErrorJSON(JSON jsn) {
    msg = jsn['msg'].stringValue;
  }

  bool get isCaptchaRequired {
    final m = msg.toLowerCase();
    return m.contains('turnstile') ||
        m.contains('captcha') ||
        m.contains('verification is required');
  }
}
