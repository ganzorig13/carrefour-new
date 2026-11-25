import 'package:carrefour/library/extensions/extended_datetime.dart';
import 'package:carrefour/library/extensions/extended_double.dart';
import 'package:carrefour/library/extensions/extended_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExtendedDouble.toCurrency', () {
    test('мянгатын таслалтай, төгрөгийн тэмдэг баруун талд', () {
      expect(12345.0.toCurrency(), '12,345₮');
      expect(1000000.0.toCurrency(), '1,000,000₮');
    });

    test('тэмдэггүй хувилбар', () {
      expect(12345.0.toCurrency(hasSymbol: false), '12,345');
    });
  });

  group('ExtendedString', () {
    test('toHexColor: 6 оронтой hex-ийг бүрэн тунгалаг өнгө болгоно', () {
      expect('#FF0000'.toHexColor(), const Color(0xFFFF0000));
      expect('00ff00'.toHexColor(), const Color(0xFF00FF00));
    });

    test('toHexColor: буруу урттай бол хар өнгө буцаана', () {
      expect('#FFF'.toHexColor(), const Color(0xFF000000));
    });

    test('toDate: буруу огноо бол одоогийн цагийг буцаана', () {
      expect('2024-05-01 10:20:30'.toDate, DateTime(2024, 5, 1, 10, 20, 30));
      final fallback = 'буруу'.toDate;
      expect(DateTime.now().difference(fallback).inSeconds.abs() < 5, isTrue);
    });

    test('toDateWithFormat', () {
      expect(
        '01/05/2024'.toDateWithFormat(format: 'dd/MM/yyyy'),
        DateTime(2024, 5, 1),
      );
    });
  });

  group('ExtendedDate', () {
    test('isSameDay нь цагийг үл тооцно', () {
      expect(
        DateTime(2024, 5, 1, 8).isSameDay(DateTime(2024, 5, 1, 23, 59)),
        isTrue,
      );
      expect(DateTime(2024, 5, 1).isSameDay(DateTime(2024, 5, 2)), isFalse);
    });

    test('toFormattedString', () {
      expect(
        DateTime(2024, 5, 1, 9, 5).toFormattedString(format: 'yyyy.MM.dd HH:mm'),
        '2024.05.01 09:05',
      );
    });
  });
}
