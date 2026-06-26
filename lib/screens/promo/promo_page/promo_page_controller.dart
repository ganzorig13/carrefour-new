import 'package:carrefour/library/library.dart';

enum PromoPageType {
  active(title: 'Даалгавар', value: 'active'),
  progress(title: 'Гүйцэтгэж байгаа', value: 'in_progress'),
  completed(title: 'Таны бэлэг', value: 'completed');

  const PromoPageType({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
}

class PromoPageController extends IOController {
  final pages = <PromoPageType>[
    PromoPageType.active,
    PromoPageType.progress,
    PromoPageType.completed,
  ];
  final refreshNotifier = NotifierModel();
}
