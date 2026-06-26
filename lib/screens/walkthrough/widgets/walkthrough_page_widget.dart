import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WalkthroughPageWidget extends StatefulWidget {
  final WalkthroughModel model;
  final Rx<WalkPosition> direction;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onLogin;
  const WalkthroughPageWidget({
    super.key,
    required this.direction,
    required this.model,
    required this.onNext,
    required this.onBack,
    required this.onLogin,
  });

  @override
  State<WalkthroughPageWidget> createState() => _WalkthroughPageWidgetState();
}

class _WalkthroughPageWidgetState extends State<WalkthroughPageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  final Tween<Offset> _offset = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  );

  @override
  void initState() {
    super.initState();
    switch (widget.direction.value) {
      case WalkPosition.left:
        _offset.begin = const Offset(1, 0.0);
        _offset.end = Offset.zero;
        break;
      case WalkPosition.right:
        _offset.begin = const Offset(-1, 0.0);
        _offset.end = Offset.zero;
        break;
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Text(
              widget.model.title,
              textAlign: TextAlign.center,
              style: IOStyles.h6,
            ),
            const SizedBox(height: 8),
            Text(
              widget.model.body,
              textAlign: TextAlign.center,
              style: IOStyles.body2Regular.copyWith(
                color: IOColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
