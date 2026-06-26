import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';

class PromoSurveyQuestionWidget extends StatelessWidget {
  final int index;
  final PromoQuestionModel question;
  final Function(int, PromoAnswerModel) onTapAnswer;

  const PromoSurveyQuestionWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onTapAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (question.photo.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: AspectRatio(
              aspectRatio: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: IOImageNetworkWidget(
                  imageUrl: question.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        Text(
          'Асуулт ${index + 1}',
          style: IOStyles.caption1Bold.copyWith(
            color: IOColors.brand700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          question.value,
          style: IOStyles.body1Regular.copyWith(
            color: IOColors.brand700,
          ),
        ),
        const SizedBox(height: 24),
        switch (question.questionType) {
          PromoQuestionType.single => question.answerDirection == Axis.vertical
              ? Column(
                  children: question.answers
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: PromoSurveySingleAnswerWidget(
                            answer: e,
                            onTap: () => onTapAnswer(index, e),
                          ),
                        ),
                      )
                      .toList(),
                )
              : Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: question.answers
                      .map(
                        (e) => PromoSurveySingleAnswerWidget(
                          answer: e,
                          onTap: () => onTapAnswer(index, e),
                        ),
                      )
                      .toList(),
                ),
          PromoQuestionType.multiple => Wrap(
              spacing: 16,
              runSpacing: 16,
              children: question.answers
                  .map(
                    (e) => PromoSurveyMultipleAnswerWidget(
                      answer: e,
                      onTap: () => onTapAnswer(index, e),
                    ),
                  )
                  .toList(),
            ),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }

  // void onTapAnswer(PromoAnswerModel answer) {
  //   switch (question.questionType) {
  //     case 'single':
  //       for (final item in question.answers) {
  //         item.selected = item.id == answer.id;
  //       }
  //       setState(() {});
  //       break;
  //     case 'multiple':
  //       setState(() {
  //         answer.selected = !answer.selected;
  //       });
  //       break;
  //   }
  // }
}
