import 'package:flutter/material.dart';

import '../../db_handler/styles.dart';
import '../../enums/quiztype_enum.dart';
import '../../quizmodels/base_create_quiz_ui_data.dart';

class MultiChoice extends QuizViewFormat {
  @override
  QuizType? get quizType => QuizType.multichoice;
  @override
  get question => question_;
  final String question_;

  final String? correctanswer;
  final List<String> answers;
  const MultiChoice({
    Key? key,
    required this.correctanswer,
    required this.answers,
    required this.question_,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List sortedAnswer = List.generate(answers.length, (index) => answers[index])
      ..add(correctanswer)
      ..shuffle();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
          child: Text(question),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              gradient: RadialGradient(
                  colors: [Theme.of(context).canvasColor, Colors.blueAccent]),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  sortedAnswer.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: correctanswer == sortedAnswer[index]
                          ? Styles.primaryThemeColor
                          : Colors.transparent,
                    ),
                    child: FittedBox(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: FittedBox(
                                child: Icon(Icons.radio_button_checked)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FittedBox(
                              child: Text(
                                sortedAnswer[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
