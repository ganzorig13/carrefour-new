import 'package:carrefour/library/client/models/pagination_model.dart';
import 'package:carrefour/library/client/models/token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:g_json/g_json.dart';

TokenModel tokenExpiringIn(Duration duration) {
  return TokenModel.fromJson(JSON({
    'access': 'access-token',
    'refresh': 'refresh-token',
    'access_expires_at': DateTime.now().add(duration).toIso8601String(),
    'refresh_expires_at':
        DateTime.now().add(const Duration(days: 30)).toIso8601String(),
  }));
}

void main() {
  group('TokenModel', () {
    test('toMap -> fromJson дахин хөрвүүлэхэд утга хадгалагдана', () {
      final token = tokenExpiringIn(const Duration(hours: 1));
      final restored = TokenModel.fromJson(JSON(token.toMap()));

      expect(restored.access, 'access-token');
      expect(restored.refresh, 'refresh-token');
      expect(restored.accessExpiresAt, token.accessExpiresAt);
      expect(restored.refreshExpiresAt, token.refreshExpiresAt);
    });

    test('isExpired: дуусахад 30 секундээс бага үлдсэн бол дууссанд тооцно', () {
      expect(tokenExpiringIn(const Duration(hours: 1)).isExpired, isFalse);
      expect(tokenExpiringIn(const Duration(seconds: 10)).isExpired, isTrue);
      expect(tokenExpiringIn(const Duration(minutes: -5)).isExpired, isTrue);
    });
  });

  group('PaginationModel', () {
    test('эхний хүсэлтийг үргэлж татна', () {
      final page = PaginationModel();
      expect(page.isInitial, isTrue);
      expect(page.shouldFetch, isTrue);
      expect(page.offset, 0);
    });

    test('нийт тооноос бага татсан бол үргэлжлүүлж татна', () {
      final page = PaginationModel()..setValue(itemCount: 20, count: 45);
      expect(page.isInitial, isFalse);
      expect(page.shouldFetch, isTrue);
      expect(page.offset, 1);

      page.setValue(itemCount: 45, count: 45);
      expect(page.shouldFetch, isFalse);
      expect(page.offset, 2);
    });

    test('reset хийхэд анхны төлөвт орно', () {
      final page = PaginationModel()
        ..setValue(itemCount: 45, count: 45)
        ..reset();
      expect(page.isInitial, isTrue);
      expect(page.shouldFetch, isTrue);
      expect(page.offset, 0);
    });
  });
}
