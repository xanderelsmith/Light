import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/utils/quiz_image_editor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../enums/quiztype_enum.dart';
import 'question_model.dart';

class MultiChoice extends Question {
  @override
  QuizType? get quizType => QuizType.multichoice;
  @override
  get question => question_;
  final String question_;
  @override
  get correctanswer => answer;
  final String? answer;
  final List? images;
  final List<String> answers;
  final int? indexM;

  @override
  get index => indexM;

  const MultiChoice({
    Key? key,
    required this.answer,
    this.indexM,
    this.images,
    required this.answers,
    required this.question_,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List sortedAnswer = List.generate(answers.length, (index) => answers[index])
      ..add(answer)
      ..shuffle();
    Size screensize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
              child: Text(question),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  gradient: RadialGradient(colors: [
                    Theme.of(context).canvasColor,
                    Colors.blueAccent
                  ]),
                ),
                child: ListView(
                    children: List.generate(
                  sortedAnswer.length,
                  (index) => Container(
                    width: screensize.width - 100,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: answer == sortedAnswer[index]
                          ? Colors.lightGreen
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(Icons.radio_button_checked),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            sortedAnswer[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: images == null || images!.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) =>
                            QuizImageEditor(images: images)));
                  },
                  icon: const CircleAvatar(child: Icon(Icons.image))),
        )
      ],
    );
  }

  ///[Map]  for generating multichoice quiz to return map which would be turned to json for backend
  @override
  Map toJson() {
    return {
      "category": quizType!.valueName,
      "question": question_,
      "correct_answer": answer,
      "incorrect_answers": answers,
      "images": images!.map((e) => ParseFile(File(e.path))).toList(),
    };
  }

  @override
  List<Object?> get props => [answer, answers, question_, quizType];

  @override
  bool? get stringify => throw UnimplementedError();
}
