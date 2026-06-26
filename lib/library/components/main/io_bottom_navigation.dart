import 'package:carrefour/library/library.dart';
import 'package:flutter/widgets.dart';

class IOBottomNavigationBar extends StatelessWidget {
  final Widget child;
  const IOBottomNavigationBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: IOColors.backgroundPrimary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
