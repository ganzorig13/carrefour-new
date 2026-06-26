import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/promo/promo_list/promo_list.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PromoListItemWidget extends StatelessWidget {
  final PromoListModel model;
  final double userPoint;

  const PromoListItemWidget({
    super.key,
    required this.model,
    required this.userPoint,
  });

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: onTapItem,
      child: SizedBox(
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 130,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: IOColors.secondary500,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          model.tag,
                          style: IOStyles.caption1Bold.copyWith(
                            color: IOColors.backgroundPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 10,
                          width: 12,
                          child: SvgPicture.asset(
                            'assets/icons/${model.isPointReward ? 'logo.svg' : 'box.gift.svg'}',
                            colorFilter: const ColorFilter.mode(
                              IOColors.backgroundPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      model.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: IOStyles.body2Semibold.copyWith(
                        color: IOColors.brand600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  switch (model.progressType) {
                    PromoType.step => PromoStepWidget(
                        totalCount: model.stepMax,
                        currentCount: model.stepCurrent,
                      ),
                    PromoType.progress => PromoProgressWidget(
                        totalAmount: model.purchaseAmount,
                        currentAmount: model.purchaseCurrent,
                      ),
                    PromoType.survey => PromoSurveyWidget(
                        questionCount: model.survey.questions.length,
                      ),
                    PromoType.point => PromoPointWidget(
                        totalPoint: model.pointAmount,
                        currentPoint: userPoint,
                      ),
                    PromoType.none => const SizedBox.shrink(),
                  },
                  const SizedBox(height: 8),
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
                        '${model.endDate.toFormattedString(format: 'MM/dd')} хүртэл',
                        style: IOStyles.caption1Medium.copyWith(
                          color: IOColors.brand400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapItem() {
    if (model.isCompleted) {
      AppRoute.toPromoInfo(promoId: model.id);
      return;
    }

    if (model.progressType == PromoType.survey) {
      AppRoute.toPromoSurvey(promoId: model.survey.id, promo: model);
      return;
    }

    AppRoute.toPromoInfo(promoId: model.id);
  }
}

class PromoStepWidget extends StatelessWidget {
  final int totalCount;
  final int currentCount;
  const PromoStepWidget({
    super.key,
    required this.totalCount,
    required this.currentCount,
  });

  double get value {
    if (currentCount == 0) return 0;
    if (totalCount == 1) return currentCount.toDouble();
    return (currentCount - 1) / (totalCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (totalCount > 1)
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 21),
            child: LinearProgressIndicator(
              backgroundColor: IOColors.brand200,
              color: IOColors.secondary500,
              value: value,
              minHeight: 1,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(totalCount, (index) => index + 1)
              .map(
                (e) => e == totalCount
                    ? getGift(e <= currentCount)
                    : getItem(e <= currentCount),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget getGift(bool selected) {
    return Container(
      width: 21,
      height: 21,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected ? IOColors.secondary500 : IOColors.brand50,
        border: selected
            ? Border.all(
                width: 1,
                color: IOColors.secondary200,
              )
            : Border.all(
                width: 1,
                color: IOColors.brand200,
              ),
      ),
      child: SvgPicture.asset(
        'assets/icons/box.gift.svg',
        width: 12,
        height: 12,
        colorFilter: ColorFilter.mode(
            selected ? IOColors.secondary50 : IOColors.brand200,
            BlendMode.srcIn),
      ),
    );
  }

  Widget getItem(bool selected) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected ? IOColors.secondary500 : IOColors.brand50,
        border: selected
            ? null
            : Border.all(
                width: 1,
                color: IOColors.brand200,
              ),
      ),
    );
  }
}

class PromoProgressWidget extends StatelessWidget {
  final double totalAmount;
  final double currentAmount;
  const PromoProgressWidget({
    super.key,
    required this.totalAmount,
    required this.currentAmount,
  });

  int get percent => (currentAmount ~/ totalAmount) * 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$percent%',
              style: IOStyles.caption1Regular.copyWith(
                color: IOColors.brand400,
              ),
            ),
            Text(
              totalAmount.toCurrency(),
              style: IOStyles.caption1Regular.copyWith(
                color: IOColors.brand400,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          backgroundColor: IOColors.brand50,
          color: IOColors.secondary500,
          borderRadius: BorderRadius.circular(4),
          value: percent / 100,
        ),
      ],
    );
  }
}

class PromoSurveyWidget extends StatelessWidget {
  final int questionCount;
  const PromoSurveyWidget({super.key, required this.questionCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$questionCount асуулт',
      style: IOStyles.caption1Regular.copyWith(
        color: IOColors.brand400,
      ),
    );
  }
}

class PromoPointWidget extends StatelessWidget {
  final double totalPoint;
  final double currentPoint;
  const PromoPointWidget({
    super.key,
    required this.totalPoint,
    required this.currentPoint,
  });

  int get percent => currentPoint >= totalPoint
      ? 100
      : ((currentPoint / totalPoint) * 100).toInt();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$percent%',
              style: IOStyles.caption1Regular.copyWith(
                color: IOColors.brand400,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: IOColors.secondary500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(
                    totalPoint.toCurrency(hasSymbol: false),
                    style: IOStyles.caption2Bold.copyWith(
                      color: IOColors.backgroundPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 12,
                    height: 10,
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      colorFilter: const ColorFilter.mode(
                        IOColors.backgroundPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          backgroundColor: IOColors.brand50,
          color: IOColors.successPrimary,
          borderRadius: BorderRadius.circular(4),
          value: percent / 100,
        ),
      ],
    );
  }
}
