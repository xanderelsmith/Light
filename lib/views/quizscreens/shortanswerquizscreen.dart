import 'package:flutter/material.dart';
import 'package:spark_ai/models/quiz_status.dart';
import 'package:spark_ai/screens/creatematerials_ui/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spark_ai/screens/creatematerials_ui/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:spark_ai/screens/quizscreens/mainquizscreen.dart';
import 'package:spark_ai/screens/quizscreens/multichoicequizscreen.dart';
import '../../enums/quiztype_enum.dart';
import '../../utilities/styles.dart';

class ShortAnswerQuizScreen extends Question {
  final int? indexS;
  @override
  // TODO: implement index
  int? get index => indexS;
  final List images;
  @override
  // TODO: implement hintimages
  get hintimages => images;
  @override
  QuizType? get quizType => QuizType.shortTextAnswer;
  @override
  String get question => questions;
  @override
  String get correctanswer => answer.toLowerCase();

  //it was named questions because theres already a variable called [question]
  final String questions;
  final String answer;
  const ShortAnswerQuizScreen({
    this.indexS,
    Key? key,
    required this.answer,
    required this.images,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizdatacontroller = ref.watch(quizcontrollerProvider);

    TextEditingController answercontroller = TextEditingController();
    Size screensize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            height: screensize.height / 3,
            width: screensize.width,
            child: Card(
                child: Stack(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(question,
                      textAlign: TextAlign.center,
                      style: Styles.titleTextStyle),
                )),
              ],
            ))),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: quizdatacontroller.answered == true
                          ? quizdatacontroller.status == QuizStatus.correct
                              ? Colors.green
                              : Colors.red
                          : Theme.of(context).hintColor,
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    enabled: !quizdatacontroller.answered ? true : false,
                    controller: answercontroller,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'write your answer here'),
                  )),
            ),
            !quizdatacontroller.answered
                ? CustomButton(
                    onTap: () {
                      ref.read(quizcontrollerProvider.notifier).submitAnswer(
                          ShortAnswer(
                              indexS: indexS,
                              answer: correctanswer,
                              questions: questions),
                          answercontroller.text.toLowerCase());
                    },
                    title: 'Check')
                : const SizedBox.shrink()
          ],
        )
      ]),
    );
  }

  @override
  Map toJson() {
    return {};
  }

  @override
  List<Object?> get props => [answer, questions, quizType];

  @override
  bool? get stringify => throw UnimplementedError();
}
