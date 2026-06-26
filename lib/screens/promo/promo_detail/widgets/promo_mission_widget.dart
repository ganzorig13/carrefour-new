import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';

class PromoMissionWidget extends StatelessWidget {
  final PromoMissionModel model;
  const PromoMissionWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: IOColors.backgroundImage,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: IOImageNetworkWidget(
                      imageUrl: model.product.photo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              if (model.totalQty > 1)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: IOColors.warningSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${model.currentQty}/${model.totalQty}',
                      style: IOStyles.caption1Medium.copyWith(
                        color: IOColors.warningPrimary,
                      ),
                    ),
                  ),
                ),
              if (model.isBought)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: IOColors.brand500,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: IOColors.brand300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: IOColors.backgroundPrimary,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Авсан',
                          style: IOStyles.caption1Bold.copyWith(
                            color: IOColors.backgroundPrimary,
                          ),
                        ),
                        const SizedBox(width: 2),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: Text(
            model.product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: IOStyles.body2Bold.copyWith(
              color: IOColors.brand700,
            ),
          ),
        )
      ],
    );
  }
}
