import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/catalog/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CatalogListItemWidget extends StatelessWidget {
  final CatalogListModel item;
  const CatalogListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: () => AppRoute.toCatalogInfo(catalogId: item.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: IOColors.backgroundPrimary,
                borderRadius: BorderRadius.circular(2),
                boxShadow: IOShadow.black2,
              ),
              child: IOImageNetworkWidget(
                imageUrl: item.thumbnailUrl,
                placeHolderIconSize: 60,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Text(
              item.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: IOStyles.body2Medium.copyWith(
                color: IOColors.brand600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  IOColors.brand300,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${item.startDate.toFormattedString(format: 'MM/dd')} - ${item.endDate.toFormattedString(format: 'MM/dd')}',
                style: IOStyles.caption1Medium.copyWith(
                  color: IOColors.brand300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
