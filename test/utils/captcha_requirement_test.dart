import 'package:carrefour/library/utils/captcha_requirement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // CaptchaRequirement нь singleton тул төлөв нь тестүүдийн хооронд хадгалагдана.
  // Иймээс дарааллаас хамаарах тул нэг тест дотор шалгав.
  test('OTP илгээх: 10 минутад 2 удаа илгээсний дараа captcha шаардана', () {
    final captcha = CaptchaRequirement.instance;

    expect(captcha.shouldRequireCaptchaForSendOtp, isFalse);
    captcha.recordSendOtpRequest();
    expect(captcha.shouldRequireCaptchaForSendOtp, isFalse);
    captcha.recordSendOtpRequest();
    expect(captcha.shouldRequireCaptchaForSendOtp, isTrue);
  });

  test('OTP шалгах: 2 удаа буруу оруулсны дараа captcha шаардаж, амжилттай бол тэглэнэ', () {
    final captcha = CaptchaRequirement.instance;
    captcha.recordSuccessVerify();

    expect(captcha.shouldRequireCaptchaForVerify, isFalse);
    captcha.recordFailedVerify();
    expect(captcha.shouldRequireCaptchaForVerify, isFalse);
    captcha.recordFailedVerify();
    expect(captcha.shouldRequireCaptchaForVerify, isTrue);

    captcha.recordSuccessVerify();
    expect(captcha.shouldRequireCaptchaForVerify, isFalse);
  });
}
