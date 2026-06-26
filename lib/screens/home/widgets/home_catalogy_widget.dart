import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCatalogyWidget extends StatelessWidget {
  final String headerText;
  final List<CatalogListModel> items;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTapMore;
  const HomeCatalogyWidget({
    super.key,
    required this.headerText,
    required this.items,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 24,
    ),
    this.onTapMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: SizedBox(
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
            ),
          ),
          SizedBox(
            height: 356,
            child: ListView.separated(
              padding: padding,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = items[index];
                return SizedBox(
                  width: 240,
                  child: CatalogListItemWidget(
                    item: item,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
