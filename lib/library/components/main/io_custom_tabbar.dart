import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOCustomTabbar extends StatelessWidget {
  final List<String> tabs;
  final bool scrollable;
  const IOCustomTabbar({
    super.key,
    required this.tabs,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: scrollable,
      tabAlignment: scrollable ? TabAlignment.start : TabAlignment.center,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: IOStyles.body2Bold.copyWith(
        color: IOColors.brand500,
      ),
      unselectedLabelStyle: IOStyles.body2Bold.copyWith(
        color: IOColors.textPrimary,
      ),
      dividerHeight: 0,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: IOColors.brand500,
            width: 2,
          ),
        ),
      ),
      tabs: tabs
          .map(
            (e) => Tab(
              text: e,
            ),
          )
          .toList(),
    );
  }
}
