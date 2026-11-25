import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

/// Лояалти tab-ын дээд хэсэгт байрлах Урамшуулал / Каталог / Карт товчлуурууд.
/// Зөвхөн ecom горимд харагдана.
class HomeLoyaltyMenuWidget extends StatelessWidget {
  final VoidCallback onTapPromo;
  final VoidCallback onTapCatalog;
  final VoidCallback? onTapCard;

  const HomeLoyaltyMenuWidget({
    super.key,
    required this.onTapPromo,
    required this.onTapCatalog,
    this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _LoyaltyMenuTile(
            label: 'Урамшуулал',
            image: 'assets/images/loyalty.promo.png',
            circleColor: const Color(0xFFFFCBCA),
            imageRect: const Rect.fromLTWH(17, 58, 74, 64),
            onTap: onTapPromo,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _LoyaltyMenuTile(
            label: 'Каталог',
            image: 'assets/images/loyalty.catalog.png',
            circleColor: const Color(0xFFFFF6C4),
            imageRect: const Rect.fromLTWH(-24.33, 42, 146, 126),
            onTap: onTapCatalog,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _LoyaltyMenuTile(
            label: 'Карт',
            image: 'assets/images/loyalty.card.png',
            circleColor: const Color(0xFFFFE6C2),
            imageRect: const Rect.fromLTWH(17, 58, 74, 64),
            onTap: onTapCard,
          ),
        ),
      ],
    );
  }
}

class _LoyaltyMenuTile extends StatelessWidget {
  final String label;
  final String image;
  final Color circleColor;

  /// Зургийн байрлал болон хэмжээ (тойргийн зүүн дээд булангаас).
  final Rect imageRect;
  final VoidCallback? onTap;

  static const _height = 94.0;
  static const _circleSize = 107.0;

  /// Тойрог card-ын дээд хэсгээс гадагш гарч, доод тал нь label-ийн дээр тулна.
  static const _circleTop = -47.0;

  const _LoyaltyMenuTile({
    required this.label,
    required this.image,
    required this.circleColor,
    required this.imageRect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(6, 8),
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final circleLeft = (constraints.maxWidth - _circleSize) / 2;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: circleLeft,
                    top: _circleTop,
                    width: _circleSize,
                    height: _circleSize,
                    child: ClipOval(
                      child: ColoredBox(
                        color: circleColor,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fromRect(
                              rect: imageRect,
                              child: Image.asset(image, fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: IOStyles.caption1Medium.copyWith(
                          color: IOColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
