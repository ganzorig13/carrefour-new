import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeBannerWidget extends StatefulWidget {
  final List<PromoBannerModel> items;
  final EdgeInsetsGeometry padding;
  const HomeBannerWidget({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  final pageController = PageController();
  int current = 1;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.padding,
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      current = index + 1;
                    });
                  },
                  children: widget.items
                      .map(
                        (e) => IOImageNetworkWidget(
                          imageUrl: e.thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: IOColors.brand900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$current/${widget.items.length}',
                      style: IOStyles.caption1Bold.copyWith(
                        color: IOColors.backgroundPrimary,
                      ),
                    ),
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
