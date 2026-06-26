import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';

class PromoSurveyMultipleAnswerWidget extends StatelessWidget {
  final PromoAnswerModel answer;
  final VoidCallback onTap;
  const PromoSurveyMultipleAnswerWidget({
    super.key,
    required this.answer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              answer.selected ? IOColors.brand50 : IOColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(8),
          border: answer.selected
              ? Border.all(
                  width: 2,
                  color: IOColors.brand400,
                )
              : null,
        ),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 16,
              child: Checkbox(
                value: answer.selected,
                onChanged: (val) => onTap(),
                activeColor: IOColors.brand500,
                side: const BorderSide(
                  width: 1,
                  color: IOColors.brand500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                answer.value,
                style: IOStyles.caption1Regular.copyWith(
                  color: IOColors.brand500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
