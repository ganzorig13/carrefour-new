import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PromoListSectionWidget extends StatelessWidget {
  final String headerText;
  final List<PromoListModel> items;
  final bool hasMore;
  final double userPoint;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTapMore;

  const PromoListSectionWidget({
    super.key,
    required this.headerText,
    required this.items,
    required this.userPoint,
    this.hasMore = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.onTapMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? SizedBox(
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        headerText,
                        style: IOStyles.body1Bold.copyWith(
                          color: IOColors.brand700,
                        ),
                      ),
                      IconButton(
                        onPressed: onTapMore,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/arrow.right.myicon.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            IOColors.brand700,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: PromoListItemWidget(
                    model: items[index - 1],
                    userPoint: userPoint,
                  ),
                );
        },
        separatorBuilder: (context, index) {
          return index == 0
              ? const SizedBox.shrink()
              : const SizedBox(height: 16);
        },
      ),
    );
  }
}
