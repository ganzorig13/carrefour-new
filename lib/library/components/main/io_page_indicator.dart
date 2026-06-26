import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IOPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  const IOPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const SlideEffect(
        dotHeight: 12,
        dotWidth: 12,
        spacing: 4,
        radius: 6,
        activeDotColor: IOColors.brand500,
        dotColor: IOColors.brand50,
      ),
    );
  }
}
