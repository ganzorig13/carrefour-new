import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';

class PromoSurveySingleAnswerWidget extends StatelessWidget {
  final PromoAnswerModel answer;
  final VoidCallback onTap;

  const PromoSurveySingleAnswerWidget({
    super.key,
    required this.answer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOButtonOpacityWidget(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: answer.selected ? IOColors.secondary500 : IOColors.brand50,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          answer.value,
          style: IOStyles.body2Bold.copyWith(
            color: answer.selected
                ? IOColors.backgroundPrimary
                : IOColors.brand200,
          ),
        ),
      ),
    );
  }
}
