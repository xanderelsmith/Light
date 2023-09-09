import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spark_ai/controllers/quizstate.dart';
import 'package:spark_ai/screens/quizscreens/mainquizscreen.dart';

import '../../controllers/quizcontroller.dart';
import '../../enums/quiztype_enum.dart';
import '../../repositories/quiz/retrieved_quizdata_repository.dart';
import '../../utilities/styles.dart';
import '../creatematerials_ui/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import '../creatematerials_ui/quizmodels/created_quiz_viewer_ui/question_model.dart';

final quizcontrollerProvider =
    StateNotifierProvider<QuizController, QuizState>((ref) {
  return QuizController();
});

class MultiChoiceQuizScreen extends Question {
  final int? indexM;
  @override
  int? get index => indexM;
  @override
  QuizType? get quizType => QuizType.multichoice;
  @override
  get question => question_;
  
  final String question_;
  final List images;
  @override
  // TODO: implement hintimages
  get hintimages => images;
  @override
  String get correctanswer => answer!;
  final String? answer;
  final List<String> answers;
  const MultiChoiceQuizScreen({
    this.indexM,
    super.key,
    required this.question_,
    required this.images,
    required this.answer,
    required this.answers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizdatacontroller = ref.watch(quizcontrollerProvider);

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(question_,
              style: Styles.titleTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: answers
                .map(
                  (e) => AnswerCard(
                      answer: e,
                      isSelected: e == quizdatacontroller.selectedAnswer,
                      isCorrect: e == correctanswer,
                      isDisplayingAnswer: quizdatacontroller.answered,
                      onTap: () {
                        ref.watch(quizcontrollerProvider.notifier).submitAnswer(
                            MultiChoice(
                                indexM: indexM,
                                answer: answer,
                                answers: answers,
                                question_: question_),
                            e);
                      }),
                )
                .toList(),
          ),
        ),
      ]),
    );
  }

  @override
  Map toJson() => {};

  @override
  List<Object?> get props => [
        question_,
        quizType,
        correctanswer,
        answers,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

//
class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: boxShadow,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
              answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

//
class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
