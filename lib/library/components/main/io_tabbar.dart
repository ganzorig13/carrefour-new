import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOTabBar extends StatelessWidget {
  final List<String> tabs;
  final bool scrollable;
  const IOTabBar({
    super.key,
    required this.tabs,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        splashBorderRadius: BorderRadius.circular(12),
        isScrollable: scrollable,
        tabAlignment: scrollable ? TabAlignment.start : null,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: IOColors.brand500,
          boxShadow: IOShadow.primary2,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        dividerHeight: 0,
        labelStyle: IOStyles.body2Medium.copyWith(
          color: IOColors.backgroundPrimary,
        ),
        unselectedLabelStyle: IOStyles.body2Medium.copyWith(
          color: IOColors.brand500,
        ),
        tabs: tabs
            .map(
              (e) => Tab(
                text: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
