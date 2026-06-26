import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class PromoRewardWidget extends StatelessWidget {
  final PromoRewardModel model;
  final String endDate;
  final VoidCallback? onTap;
  const PromoRewardWidget({
    super.key,
    required this.model,
    required this.endDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SizedBox(
          height: 108,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: IOColors.backgroundImage,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: IOImageNetworkWidget(
                          imageUrl: model.photo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: model.status.backgroundColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          model.status.title,
                          style: IOStyles.caption2Medium.copyWith(
                            color: model.status.foregroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Text(
                        model.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: IOStyles.body2Bold.copyWith(
                          color: IOColors.brand700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (model.rewardType == 'free_product') ...[
                      Text(
                        '${model.qnty}ш',
                        style: IOStyles.body2Medium.copyWith(
                          color: IOColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            IOColors.brand400,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$endDate хүртэл',
                          style: IOStyles.caption1Medium.copyWith(
                            color: IOColors.brand400,
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
      ),
    );
  }
}
