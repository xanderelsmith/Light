import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/db_handler/styles.dart';
import 'package:light/utils/quiz_image_editor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../enums/quiztype_enum.dart';
import 'question_model.dart';

class ShortAnswer extends Question {
  @override
  QuizType? get quizType => QuizType.shortTextAnswer;
  @override
  String get question => questions;
  @override
  String get correctanswer => answer;
  final List? images;
  final int? indexS;
  @override
  get index => indexS;
  final String questions;
  final String answer;
  const ShortAnswer({
    this.images,
    Key? key,
    this.indexS,
    required this.answer,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(children: [
          Expanded(
            flex: 2,
            child: Center(
                child: Card(
                    child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                questions,
                textAlign: TextAlign.center,
              ),
            ))),
          ),
          Expanded(
              flex: 5,
              child: Center(
                  child: Card(
                      color: Styles.primaryThemeColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Text(answer),
                      ))))
        ]),
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

  ///[Map]  for generating [ShortAnswer] quiz to return map which would be turned to json for backend
  @override
  Map toJson() {
    return {
      "category": quizType!.valueName,
      "question": question,
      "correct_answer": answer,
      "images": images!.map((e) => ParseFile(File(e.path))).toList(),
    };
  }

  @override
  List<Object?> get props => [answer, questions, quizType];

  @override
  bool? get stringify => throw UnimplementedError();
}
