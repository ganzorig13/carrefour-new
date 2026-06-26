import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum TurnstileStatus { loading, verifying, interactive, success, error, expired }

class TurnstileManagedWidget extends StatefulWidget {
  final String siteKey;
  final void Function(String token) onToken;
  final VoidCallback? onError;
  final String? remoteUrl;
  final String? baseUrl;

  const TurnstileManagedWidget({
    super.key,
    required this.siteKey,
    required this.onToken,
    this.onError,
    this.remoteUrl,
    this.baseUrl,
  });

  @override
  State<TurnstileManagedWidget> createState() => TurnstileManagedWidgetState();
}

class TurnstileManagedWidgetState extends State<TurnstileManagedWidget> {
  late final WebViewController _controller;
  TurnstileStatus _status = TurnstileStatus.loading;
  bool _tokenDelivered = false;

  TurnstileStatus get status => _status;

  void reset() {
    setState(() => _status = TurnstileStatus.verifying);
    _controller.runJavaScript('turnstile.reset("#turnstile-widget")');
  }

  @override
  void initState() {
    super.initState();
    final siteKey = _escapeJsString(widget.siteKey);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'TurnstileChannel',
        onMessageReceived: _handleMessage,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _status = TurnstileStatus.verifying);
          },
        ),
      );

    if (widget.remoteUrl != null) {
      _controller.loadRequest(Uri.parse(widget.remoteUrl!));
    } else {
      _controller.loadHtmlString(
        _buildHtml(siteKey),
        baseUrl: widget.baseUrl != null && widget.baseUrl!.isNotEmpty
            ? (widget.baseUrl!.endsWith('/')
                ? widget.baseUrl!
                : '${widget.baseUrl!}/')
            : 'https://challenges.cloudflare.com/',
      );
    }
  }

  static String _escapeJsString(String s) {
    return s.replaceAll('\\', r'\\').replaceAll("'", r"\'");
  }

  void _handleMessage(JavaScriptMessage message) {
    final msg = message.message;

    if (msg.startsWith('token:')) {
      if (_tokenDelivered) return;
      _tokenDelivered = true;
      setState(() => _status = TurnstileStatus.success);
      widget.onToken(msg.substring(6));
    } else if (msg == 'interactive') {
      setState(() => _status = TurnstileStatus.interactive);
    } else if (msg == 'expired') {
      setState(() => _status = TurnstileStatus.expired);
      reset();
    } else if (msg == 'error') {
      setState(() => _status = TurnstileStatus.error);
      widget.onError?.call();
    }
  }

  String _buildHtml(String siteKey) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
  <style>
    * { margin: 0; padding: 0; }
    html, body {
      width: 100%; height: 100%;
      display: flex; justify-content: center; align-items: center;
      background: transparent; overflow: hidden;
    }
  </style>
</head>
<body>
  <div id="turnstile-widget"></div>
  <script>
    function renderWidget() {
      if (typeof turnstile === 'undefined') {
        setTimeout(renderWidget, 100);
        return;
      }
      turnstile.render('#turnstile-widget', {
        sitekey: '$siteKey',
        theme: 'light',
        callback: function(token) {
          if (window.TurnstileChannel) window.TurnstileChannel.postMessage('token:' + token);
        },
        'before-interactive-callback': function() {
          if (window.TurnstileChannel) window.TurnstileChannel.postMessage('interactive');
        },
        'expired-callback': function() {
          if (window.TurnstileChannel) window.TurnstileChannel.postMessage('expired');
        },
        'error-callback': function() {
          if (window.TurnstileChannel) window.TurnstileChannel.postMessage('error');
        }
      });
    }
    renderWidget();
  </script>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_status) {
      case TurnstileStatus.loading:
      case TurnstileStatus.verifying:
        return SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 12,
                height: 12,
                child: IOLoading(
                  strokeWidth: 2,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Шалгаж байна...',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
        );

      case TurnstileStatus.success:
        return SizedBox(
          height: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 14, color: Colors.green.shade600),
              const SizedBox(width: 6),
              Text(
                'Баталгаажсан',
                style: TextStyle(fontSize: 12, color: Colors.green.shade600),
              ),
            ],
          ),
        );

      case TurnstileStatus.interactive:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Доорх баталгаажуулалтыг бөглөнө үү',
                style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
              ),
            ),
            SizedBox(
              height: 65,
              child: WebViewWidget(controller: _controller),
            ),
          ],
        );

      case TurnstileStatus.error:
        return SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 14, color: Colors.red.shade600),
              const SizedBox(width: 6),
              Text(
                'Алдаа гарлаа',
                style: TextStyle(fontSize: 12, color: Colors.red.shade600),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: reset,
                child: Text(
                  'Дахин оролдох',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );

      case TurnstileStatus.expired:
        return const SizedBox(height: 30);
    }
  }
}
