import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Turnstile-ийн стандарт өргөн 300px; padding 24*2 тул dialog-ийн дотоод өргөн 300+ болгоно.
const double _kCaptchaDialogMinWidth = 348;
const double _kCaptchaDialogHorizontalMargin = 24;

Future<String?> showValidationTokenDialog() async {
  final context = Get.context;
  if (context == null) return null;

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      final navigator = Navigator.of(ctx);
      final screenWidth = MediaQuery.sizeOf(ctx).width;
      final maxWidth = screenWidth - (_kCaptchaDialogHorizontalMargin * 2);

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: _kCaptchaDialogMinWidth,
            maxWidth: maxWidth,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 24,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: TurnstileManagedWidget(
                  siteKey: kTurnstileSiteKey,
                  baseUrl: domain,
                  onToken: (token) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (navigator.mounted) navigator.pop(token);
                    });
                  },
                  onError: () {},
                ),
              ),
            ),
          ),
        );
    },
  );
}

Future<IOResponse> retryWithCaptchaIfRequired(
  IOResponse response,
  Future<IOResponse> Function(String token) retry,
) async {
  if (response.isSuccess || !response.isCaptchaRequired) return response;
  final token = await showValidationTokenDialog();
  if (token == null || token.isEmpty) return response;
  return retry(token);
}
