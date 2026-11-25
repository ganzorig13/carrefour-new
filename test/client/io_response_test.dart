import 'package:carrefour/library/client/io_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:g_json/g_json.dart';

void main() {
  group('IOResponse', () {
    test('амжилттай хариуг задлана', () {
      final response = IOResponse.fromJSON(JSON({
        'success': true,
        'msg': 'OK',
        'data': {'id': 7, 'name': 'Carrefour'},
      }));

      expect(response.isSuccess, isTrue);
      expect(response.msg, 'OK');
      expect(response.data['id'].integerValue, 7);
      expect(response.json['data']['name'].stringValue, 'Carrefour');
    });

    test('success талбаргүй бол амжилтгүйд тооцно', () {
      final response = IOResponse.fromJSON(JSON({'msg': 'алдаа'}));
      expect(response.isSuccess, isFalse);
      expect(response.msg, 'алдаа');
    });

    test('withError болон withErrorJSON нь амжилтгүй байна', () {
      final plain = IOResponse.withError('Connection time out');
      expect(plain.isSuccess, isFalse);
      expect(plain.msg, 'Connection time out');

      final fromJson = IOResponse.withErrorJSON(JSON({'msg': 'Буруу код'}));
      expect(fromJson.isSuccess, isFalse);
      expect(fromJson.msg, 'Буруу код');
    });

    test('isCaptchaRequired: backend-ийн мессежээс captcha шаардлагыг танина', () {
      expect(IOResponse.withError('Turnstile token missing').isCaptchaRequired,
          isTrue);
      expect(IOResponse.withError('CAPTCHA failed').isCaptchaRequired, isTrue);
      expect(
        IOResponse.withError('Verification is required').isCaptchaRequired,
        isTrue,
      );
      expect(IOResponse.withError('Буруу код').isCaptchaRequired, isFalse);
    });
  });
}
