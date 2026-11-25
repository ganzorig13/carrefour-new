import 'package:carrefour/library/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

// Тухайн нэг төрлийн шалгалтаар текст хүчинтэй эсэхийг буцаана.
bool valid(ValidatorType type, String text) =>
    Validator(validations: [type]).isValid(text).$1;

void main() {
  group('Validator', () {
    test('утасны дугаар: 6-9-өөр эхэлсэн 8 оронтой тоо', () {
      expect(valid(ValidatorType.phone, '99112233'), isTrue);
      expect(valid(ValidatorType.phone, '60112233'), isTrue);
      expect(valid(ValidatorType.phone, '50112233'), isFalse);
      expect(valid(ValidatorType.phone, '9911223'), isFalse);
      expect(valid(ValidatorType.phone, '991122334'), isFalse);
      expect(valid(ValidatorType.phone, '9911a233'), isFalse);
    });

    test('PIN: яг 6 оронтой тоо', () {
      expect(valid(ValidatorType.pin, '123456'), isTrue);
      expect(valid(ValidatorType.pin, '12345'), isFalse);
      expect(valid(ValidatorType.pin, '1234567'), isFalse);
      expect(valid(ValidatorType.pin, '12345a'), isFalse);
    });

    test('регистрийн дугаарын тоон хэсэг (YYMMDD + 2 орон)', () {
      expect(valid(ValidatorType.registerNumber, '95041512'), isTrue);
      // 2000 оноос хойш төрсөн бол сар +20 байдаг
      expect(valid(ValidatorType.registerNumber, '05241512'), isTrue);
      expect(valid(ValidatorType.registerNumber, '95131512'), isFalse);
      expect(valid(ValidatorType.registerNumber, '95043212'), isFalse);
    });

    test('кирилл үсэг', () {
      expect(valid(ValidatorType.cyrillic, 'Батболд'), isTrue);
      expect(valid(ValidatorType.cyrillic, 'Өлзий-Орших'), isTrue);
      expect(valid(ValidatorType.cyrillic, 'Bat'), isFalse);
      expect(valid(ValidatorType.cyrillic, 'Бат 1'), isFalse);
    });

    test('мөнгөн дүн: 0-ээр эхлэхгүй бүхэл тоо', () {
      expect(valid(ValidatorType.amount, '1000'), isTrue);
      expect(valid(ValidatorType.amount, '0100'), isFalse);
      expect(valid(ValidatorType.amount, '10.5'), isFalse);
    });

    test('и-мэйл', () {
      expect(valid(ValidatorType.email, 'user@carrefour.mn'), isTrue);
      expect(valid(ValidatorType.email, 'user@carrefour'), isFalse);
      expect(valid(ValidatorType.email, 'carrefour.mn'), isFalse);
    });

    test('нууц үг: хамгийн багадаа 6 тэмдэгт', () {
      expect(valid(ValidatorType.password, 'abc123'), isTrue);
      expect(valid(ValidatorType.password, 'abc12'), isFalse);
    });

    test('хоосон биш', () {
      expect(valid(ValidatorType.notEmpty, 'a'), isTrue);
      expect(valid(ValidatorType.notEmpty, '   '), isFalse);
      expect(valid(ValidatorType.notEmpty, ''), isFalse);
    });

    test('хэд хэдэн шалгалтаас эхний унасных нь алдааг буцаана', () {
      final validator = Validator(
        validations: [ValidatorType.notEmpty, ValidatorType.phone],
      );
      expect(validator.isValid(''), (false, ValidatorType.notEmpty.errorText));
      expect(validator.isValid('123'), (false, ValidatorType.phone.errorText));
      expect(validator.isValid('88112233'), (true, null));
    });
  });
}
