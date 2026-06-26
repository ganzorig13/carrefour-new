import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePromoBannerWidget extends StatefulWidget {
  final List<PromoBannerModel> items;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int>? onTap;

  const HomePromoBannerWidget({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.onTap,
  });

  @override
  State<HomePromoBannerWidget> createState() => _HomePromoBannerWidgetState();
}

class _HomePromoBannerWidgetState extends State<HomePromoBannerWidget> {
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.padding,
      sliver: SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: widget.items
                      .mapIndexed(
                        (i, e) => IOButtonOpacityWidget(
                          onTap: () => widget.onTap?.call(i),
                          child: IOImageNetworkWidget(
                            imageUrl: e.thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SmoothPageIndicator(
                              controller: pageController,
                              count: widget.items.length,
                              effect: ScrollingDotsEffect(
                                dotWidth: 50,
                                dotHeight: 2,
                                spacing: 8,
                                activeDotScale: 1,
                                radius: 4,
                                dotColor:
                                    IOColors.backgroundPrimary.withOpacity(0.3),
                                activeDotColor: IOColors.backgroundPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.items[currentIndex].title,
                                    style: IOStyles.body1Medium.copyWith(
                                      color: IOColors.backgroundPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: IOColors.brand900.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${currentIndex + 1}/${widget.items.length}',
                                    style: IOStyles.caption1Bold.copyWith(
                                      color: IOColors.backgroundPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
