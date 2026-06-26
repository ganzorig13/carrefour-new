import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';

class PromoBannerController extends IOController {
  final List<PromoBannerModel> items;
  int index;

  PromoBannerController({
    required this.items,
    required this.index,
  });
}
