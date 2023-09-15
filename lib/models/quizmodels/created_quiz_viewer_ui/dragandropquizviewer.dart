import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/services/styles.dart';

import '../../../../enums/quiztype_enum.dart';
import 'question_model.dart';

class DragAndDrop extends Question {
  @override
  QuizType? get quizType => QuizType.draganddrop;
  final String questions;
  final int? indexD;
  @override
  // TODO: implement index
  int? get index => indexD;
  @override
  get question => questions;
  @override
  List<String> get correctanswer => correctanswers!;
  final List<String>? correctanswers;
  final List<String> incorrectanswers;
  const DragAndDrop({
    this.indexD,
    Key? key,
    required this.correctanswers,
    required this.incorrectanswers,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List allOptionsList = List.generate(
        incorrectanswers.length, (index) => incorrectanswers[index])
      ..addAll(correctanswers!)
      ..shuffle();
    List questionList = questions.split(" ");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Center(
                child: Card(
                  color: Color.lerp(const Color.fromARGB(255, 87, 130, 196),
                      Colors.lightBlueAccent, 0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                          questionList.length,
                          (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 2),
                                child: Text(
                                  questionList[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: allOptionsList.contains(
                                                  questionList[index]) ==
                                              true
                                          ? Styles.primaryThemeColor
                                          : null),
                                ),
                              )),
                    ),
                  ),
                ),
              )),
          Expanded(
              child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(
                allOptionsList.length,
                (index) => Card(
                    color: questionList.contains(allOptionsList[index]) == true
                        ? Styles.primaryThemeColor
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4),
                      child: Text(allOptionsList[index]),
                    ))),
          )),
        ],
      ),
    );
  }

  ///[Map]  for generating drag and drop quiz to return map which would be turned to json for backend
  @override
  Map toJson() {
    return {
      "category": quizType!.valueName,
      "question": questions,
      "wrong_answer_list": incorrectanswers,
      "correct_answers": correctanswers
    };
  }

  @override
  List<Object?> get props =>
      [correctanswers, incorrectanswers, questions, quizType];

  @override
  bool? get stringify => throw UnimplementedError();
}
