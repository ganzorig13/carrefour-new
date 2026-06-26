import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends IOController {
  final String urlString;
  final String titleText;
  final webController = WebViewController();

  WebviewController({
    required this.urlString,
    required this.titleText,
  });

  @override
  void onReady() {
    super.onReady();

    final uri = Uri.parse(urlString);

    if (uri.isAbsolute) {
      webController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.transparent)
        ..loadRequest(uri);
    } else {
      Get.back();
      showError(text: 'Линк буруу байна');
    }
  }
}
