import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class WebviewBinding extends Bindings {
  final String title;
  final String urlString;

  WebviewBinding({
    required this.urlString,
    required this.title,
  });

  @override
  void dependencies() {
    Get.lazyPut(() => WebviewController(
          urlString: urlString,
          titleText: title,
        ));
  }
}
